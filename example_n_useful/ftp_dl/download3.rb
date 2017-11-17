require 'time'
require 'net/ftp'

module Net #:nodoc:
  class FTP #:nodoc:

    module List
      def self.parse(*args)
        Parser.parse(*args)
      end

      class ParserError < RuntimeError; end

      class Parser
        @@parsers = []

        def initialize(raw)
          @raw = raw
        end

        # The raw list entry string.
        def raw
          @raw ||= ''
        end
        alias_method :to_s, :raw

        # The items basename (filename).
        def basename
          @basename ||= ''
        end

        # Looks like a directory, try CWD.
        def dir?
          !!(@dir ||= false)
        end

        # Looks like a file, try RETR.
        def file?
          !!(@file ||= false)
        end

        # Looks like a symbolic link.
        def symlink?
          !!(@symlink ||= false)
        end

        def mtime
          @mtime
        end

        def filesize
          @filesize
        end

        class << self
          def inherited(klass) #:nodoc:
            @@parsers << klass
          end

          def parse(raw)
            @@parsers.reverse.each do |parser|
              begin
                return parser.new(raw)
              rescue ParserError
                next
              end
            end
          end
        end
      end

      class Unix < Parser

        # Stolen straight from the ASF's commons Java FTP LIST parser library.
        # http://svn.apache.org/repos/asf/commons/proper/net/trunk/src/java/org/apache/commons/net/ftp/
        REGEXP = %r{
          ([bcdlfmpSs-])
          (((r|-)(w|-)([xsStTL-]))((r|-)(w|-)([xsStTL-]))((r|-)(w|-)([xsStTL-])))\+?\s+
          (\d+)\s+
          (\S+)\s+
          (?:(\S+(?:\s\S+)*)\s+)?
          (\d+)\s+
          ((?:\d+[-/]\d+[-/]\d+)|(?:\S+\s+\S+))\s+
          (\d+(?::\d+)?)\s+
          (\S*)(\s*.*)
        }x

        # Parse a Unix like FTP LIST entries.
        def initialize(raw)
          super(raw)
          match = REGEXP.match(raw.strip) or raise ParserError

          case match[1]
            when /d/    then @dir = true
            when /l/    then @symlink = true
            when /[f-]/ then @file = true
            when /[bc]/ then # Do nothing with devices for now.
            else ParserError 'Unknown LIST entry type.'
          end

          # TODO: Permissions, users, groups, date/time.
          @filesize = match[18].to_i
          @mtime = Time.parse("#{match[19]} #{match[20]}")

          @basename = match[21].strip

          # filenames with spaces will end up in the last match
          @basename += match[22] unless match[22].nil?

          # strip the symlink stuff we don't care about
          @basename.sub!(/\s+\->.+$/, '') if @symlink
        end
      end
    end
  end
end

time = Time.new
SECONDS_PER_DAY = 60 * 60 * 24
time -= 40 * SECONDS_PER_DAY

ftp = Net::FTP.new('ftp.mozilla.org')
ftp.login
ftp.chdir('pub/firefox/releases/19.0.2/linux-i686/xpi')

lst = [ nil ]

ftp.list('*') do |f|
    entry = Net::FTP::List.parse(f)
    next unless (entry.mtime > time and entry.file?)
    lst.insert(0, entry.basename)
end

for file in lst
    next if file == nil
    puts "Downloading #{file}"
    ftp.getbinaryfile(file)
end

ftp.close

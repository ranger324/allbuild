#kernel config
#|# CONFIG_MAGIC_SYSRQ is not set
#sysctl kernel.sysrq=1
#echo "1" > /proc/sys/kernel/sysrq
#/etc/sysctl.conf kernel.sysrq = 1
#kernel parameter sysrq_always_enabled=1
#   Alt+SysRq+r Unraw     Take control of keyboard back from X.
#   Alt+SysRq+e Terminate Send SIGTERM to all processes, allowing them to
#                         terminate gracefully.
#   Alt+SysRq+i Kill      Send SIGKILL to all processes, forcing them to
#                         terminate immediately.
#   Alt+SysRq+s Sync      Flush data to disk.
#   Alt+SysRq+u Unmount   Unmount and remount all filesystems read-only.
#   Alt+SysRq+b Reboot    Reboot

#"ctrl-v" and then "key" - echo esc seq
#showkey -a

#bash
#bind -p

#in script
#set -o emacs
#or
#set -o vi

#F12
#bind '"\e[24~":"free\nsync\n"'
#Ctrl-e
#bind '"\C-e":"df\n"'

#other setting - keyboard map
#echo to terminal
#alt-gr - d
(dumpkeys; echo -ne 'altgr keycode 32 = F100\nstring F100 = "free\nsync\n"\n') | loadkeys

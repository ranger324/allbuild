#! /bin/bash

find -type d | while read dirs; do chmod 755 "$dirs"; done
find -type f | while read files; do chmod 644 "$files"; done

#!/usr/bin/env zsh

# Source all function files
for file in ${0:A:h}/zfunctions/*.zsh; do
  source "$file"
done
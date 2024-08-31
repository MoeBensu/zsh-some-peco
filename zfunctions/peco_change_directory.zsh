#!/usr/bin/env zsh

# Default configurations
typeset -gA PECO_CD_CONFIG=(
  [layout]="bottom-up"
  [prompt]="cd>"
  [extra_flags]=""
  [keymap]="^F"
  [custom_dirs]=""
)

_peco_change_directory() {
  local peco_flags=(
    "--layout=${PECO_CD_CONFIG[layout]}"
    "--prompt" "${PECO_CD_CONFIG[prompt]}"
  )
  [ -n "${PECO_CD_CONFIG[extra_flags]}" ] && peco_flags+=("${(z)PECO_CD_CONFIG[extra_flags]}")
  [ $# -ne 0 ] && peco_flags+=("--query" "$*")

  local selected=$(peco "${peco_flags[@]}" | perl -pe 's/([ ()])/\\\\$1/g')
  if [ -n "$selected" ]; then
    BUFFER="cd $selected"
    zle accept-line
  fi
  zle -R -c
}

peco_change_directory() {
  local dirs=(
    "$HOME/.config"
  )
  
  # Add ghq repositories if ghq is installed
  if (( $+commands[ghq] )); then
    dirs+=($(ghq list -p))
  fi
  
  # Add root directories
  dirs+=($(ls -ad -- /* | perl -pe "s#^#$PWD#" | grep -v '\.git'))
  
  # Add home subdirectories
  dirs+=($(ls -ad -- "$HOME/"*/* | grep -v '\.git'))
  
  # Custom directories
  [ -n "${PECO_CD_CONFIG[custom_dirs]}" ] && dirs+=("${(z)PECO_CD_CONFIG[custom_dirs]}")

  print -l "${(u)dirs[@]}" | sed -e 's/\/$//' | _peco_change_directory "$@"
}

zle -N peco_change_directory
bindkey "${PECO_CD_CONFIG[keymap]}" peco_change_directory
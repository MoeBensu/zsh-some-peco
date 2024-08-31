#!/usr/bin/env zsh

# Default configurations
typeset -gA PECO_HISTORY_CONFIG=(
  [layout]="bottom-up"
  [prompt]="HISTORY>"
  [initial_filter]="Fuzzy"
  [extra_flags]=""
  [keymap]="^R"
)

peco_select_history() {
  local peco_flags=(
    "--layout=${PECO_HISTORY_CONFIG[layout]}"
    "--prompt" "${PECO_HISTORY_CONFIG[prompt]}"
    "--initial-filter=${PECO_HISTORY_CONFIG[initial_filter]}"
  )
  [ -n "${PECO_HISTORY_CONFIG[extra_flags]}" ] && peco_flags+=("${(z)PECO_HISTORY_CONFIG[extra_flags]}")
  [ $# -ne 0 ] && peco_flags+=("--query" "$1")

  local selected=$(fc -rl 1 | 
    awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    peco "${peco_flags[@]}" |
    awk '{$1=""; print substr($0,2)}')
  
  if [ -n "$selected" ]; then
    BUFFER=$selected
    CURSOR=$#BUFFER
    zle redisplay
  else
    zle reset-prompt
  fi
}

zle -N peco_select_history
bindkey "${PECO_HISTORY_CONFIG[keymap]}" peco_select_history
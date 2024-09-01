#!/usr/bin/env zsh

# Clone the repository
git clone https://github.com/MoeBensu/zsh-some-peco.git

# Append the plugin source line to .zshrc
echo "\n\n# zsh some peco plugin\n" >> ${ZDOTDIR:-$HOME}/.zshrc
echo "source ${(q-)PWD}/zsh-some-peco/zsh-some-peco.plugin.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# Reload the shell configuration
source ${ZDOTDIR:-$HOME}/.zshrc
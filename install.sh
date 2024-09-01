#!/usr/bin/env zsh

cd ${ZDOTDIR:-$HOME}

repo_name="zsh-some-peco"
repo_url="https://github.com/MoeBensu/$repo_name.git"

if git clone --depth=1 "$repo_url" > /dev/null 2>&1; then
    echo "Successfully cloned $repo_name repository."
else
    if [ -d "$repo_name" ]; then
        echo "Repository already exists. Skipping clone."
    else
        echo "Failed to clone $repo_name repository."
        git clone --depth=1 "$repo_url"
    fi
fi

# Append the plugin source line to .zshrc if it doesn't already exist
if ! grep -q "source ${(q-)PWD}/$repo_name/zsh-some-peco.plugin.zsh" ${ZDOTDIR:-$HOME}/.zshrc; then
    echo "\n# some peco zsh plugin" >> ${ZDOTDIR:-$HOME}/.zshrc
    echo "source ${(q-)PWD}/$repo_name/zsh-some-peco.plugin.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
    echo "Added $repo_name plugin to .zshrc"
else
    echo "$repo_name plugin already exists in .zshrc"
    exit 1
fi

# Reload the shell configuration
source ${ZDOTDIR:-$HOME}/.zshrc
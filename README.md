A Zsh plugin that enhances your command-line experience with Peco, i.e. providing quick directory navigation and history search.

## Current Supported Features

- Quick directory navigation
- Enhanced history search

## Installation (wip)
Add one of the following lines to your `.zshrc` depending on your preferred zsh plugin manager:

### Using a Zsh Plugin Manager (recommended)
coming soon!

#### Antigen

```zsh
antigen bundle MoeBensu/zsh-some-peco
```

#### zinit
```zsh
antigen bundle MoeBensu/zsh-some-peco
```

#### zplug
```zsh
zplug "MoeBensu/peco-zsh-plugin"
```

#### Manual
Or if you prefer to install it manually:
```zsh
git clone https://github.com/MoeBensu/zsh-some-peco.git
echo "\n\n# zsh some peco plugin" >> ${ZDOTDIR:-$HOME}/.zshrc
echo "source ${(q-)PWD}/zsh-some-peco/zsh-some-peco.plugin.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
```

After installation, you would need to reload your shell or run:
```zsh
source ~/.zshrc
```

## Settings
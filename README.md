# Omarchy Theme Integration

A Neovim plugin that syncs your editors colorscheme with the rest of Omarchy. Omarchy ships with this feature out of the box, but it requires the use of LazyVim. This plugin works independent of LazyVim. It integrates with the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## Installation

lazy.nvim
```lua
{
    "rgarofano/omarchy-theme.nvim",
    config = function()
        require("omarchy-theme").setup()
    end
}
```

## Supported Themes

* Catppuccin
* Everforest
* Gruvbox
* Kanagawa
* Matte Black
* Nord
* Osaka Jade
* Tokyo Night

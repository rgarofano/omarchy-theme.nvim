# Omarchy Theme Integration

A Neovim plugin that syncs your editors colorscheme with the rest of Omarchy. Omarchy ships with this feature out of the box, but it requires the use of LazyVim. This plugin works independent of LazyVim. It integrates with the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## Installation

lazy.nvim
```lua
{
    "rgarofano/omarchy-theme.nvim",
    dependencies = {
        {
            "catppuccin/nvim",
            name = "catppuccin",
            lazy = true,
            config = function()
                require("catppuccin").setup({
                    transparent_background = true,
                    float = {
                        transparent = false,
                        solid = false,
                    }
                })
            end,
        },
        {
            "ribru17/bamboo.nvim",
            name = "bamboo",
            lazy = true,
            config = function()
                require("bamboo").setup({
                    transparent = true,
                })
            end,
        },
        {
            "folke/tokyonight.nvim",
            name = "tokyonight",
            lazy = true,
            config = function()
                require("tokyonight").setup({
                    transparent = true
                })
            end
        },
        {
            "neanias/everforest-nvim",
            name = "everforest",
            lazy = true
        },
        {
          "ellisonleao/gruvbox.nvim",
          name = "gruvbox",
          lazy = true
        },
        {
            "rebelot/kanagawa.nvim",
            name = "kanagawa",
            lazy = true
        },
        {
            "tahayvr/matteblack.nvim",
            name = "matteblack",
            lazy = true
        },
        {
            "EdenEast/nightfox.nvim",
            name = "nordfox",
            lazy = true
        },
    },
    config = function()
        require("omarchy-theme").setup()
    end,
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

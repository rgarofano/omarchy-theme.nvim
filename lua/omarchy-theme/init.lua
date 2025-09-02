local supported_themes = {
    catppuccin = {
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

    bamboo = {
        "ribru17/bamboo.nvim",
        name = "bamboo",
        lazy = true,
        config = function()
            require("bamboo").setup({
                transparent = true,
            })
        end,
    },

    tokyonight = {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        lazy = true,
        config = function()
            require("tokyonight").setup({
                transparent = true
            })
        end
    },

    everforest = { "neanias/everforest-nvim",    name = "everforest",  lazy = true },
    gruvbox =    { "ellisonleao/gruvbox.nvim",   name = "gruvbox",     lazy = true },
    kanagawa =   { "rebelot/kanagawa.nvim",      name = "kanagawa",    lazy = true },
    matteblack = { "tahayvr/matteblack.nvim",    name = "matteblack",  lazy = true },
    nordfox =    { "EdenEast/nightfox.nvim",     name = "nordfox",     lazy = true },
}

-- Helper Functions --

local function omarchy_theme_file()
    local ok, file_contents = pcall(dofile, vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua"))
    if not ok then
      vim.notify("No omarchy theme file found", vim.log.levels.WARN)
      return nil
    end
    return file_contents
end

local function parse_colorscheme(theme_file_contents)
    if not theme_file_contents then
        return "default"
    end

    for _, plugin in ipairs(theme_file_contents) do
        if type(plugin) == "table" and #plugin > 0 and plugin.opts and plugin.opts.colorscheme then
            return plugin.opts.colorscheme
        elseif type(plugin) == "string" and plugin == "ribru17/bamboo.nvim" then
            return "bamboo"
        end
    end

    return "default"
end

local function set_current_theme()
    local colorscheme = parse_colorscheme(omarchy_theme_file())

    if colorscheme == "default" or not supported_themes[colorscheme] then
        vim.cmd.colorscheme("default")
        return
    end

    if not require("lazy.core.config").plugins[colorscheme] then
        require("lazy").install(supported_themes[colorscheme])
    end

    require("lazy").load({ plugins = { colorscheme } })
    vim.cmd.colorscheme(colorscheme)
end

-- Plugin Exports --

local omarchy_theme = {}

function omarchy_theme.setup()
    vim.schedule(set_current_theme)

    -- Watch for changes to the omarchy theme directory symlink
    local watcher = vim.loop.new_fs_event()
    if watcher then
        watcher:start(vim.fn.expand("~/.config/omarchy/current"), {}, function(err, filename, _)
            if err then
                vim.notify("Theme watcher: " .. err, vim.log.levels.ERROR)
            end
            if filename == "theme" then
                vim.schedule(set_current_theme)
            end
        end)
    else
        vim.notify("Unable to start theme watcher", vim.log.levels.WARN)
    end
end

function omarchy_theme.spec()
    local spec = {}
    for _, theme_plugin in pairs(supported_themes) do
        table.insert(spec, theme_plugin)
    end
    return spec
end

return omarchy_theme

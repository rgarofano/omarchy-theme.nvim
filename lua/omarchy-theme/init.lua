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

    if colorscheme == "default" then
        vim.cmd("hi clear")
        vim.cmd.colorscheme("default")
        return
    end

    if colorscheme == "catppuccin-latte" or colorscheme == "rose-pine-dawn" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end

    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    if colorscheme == "catppuccin-latte" then
        require("lazy").load({ plugins = { "catppuccin" } })
        require("catppuccin").setup({
            flavour = "latte",
        })
    elseif colorscheme == "catppuccin" then
        require("lazy").load({ plugins = { "catppuccin" } })
        require("catppuccin").setup({
            flavour = "mocha",
        })
    else
        require("lazy").load({ plugins = { colorscheme } })
    end

    if colorscheme == "rose-pine-dawn" then
        colorscheme = "rose-pine"
    end

    vim.cmd.colorscheme(colorscheme)
end

-- Plugin Exports --

local omarchy_theme = {}

function omarchy_theme.setup()
    set_current_theme()

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

return omarchy_theme

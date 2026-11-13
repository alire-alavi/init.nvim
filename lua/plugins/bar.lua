return {
    {
        "dgox16/oldworld.nvim"
    },
    {
        "ramojus/mellifluous.nvim"
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'everviolet/nvim',
        name = 'evergarden',
        priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
        opts = {
            theme = {
                variant = 'fall', -- 'winter'|'fall'|'spring'|'summer'
                accent = 'green',
            },
            editor = {
                transparent_background = true,
                sign = { color = 'none' },
                float = {
                    color = 'mantle',
                    solid_border = false,
                },
                completion = {
                    color = 'surface0',
                },
            },
        }
    },
    {
        'ray-x/aurora',
        init = function()
            vim.g.aurora_italic = 1
            vim.g.aurora_transparent = 1
            vim.g.aurora_bold = 1
        end,
    },
    {
        'shaunsingh/nord.nvim'
    },
    {
        "savq/melange-nvim"
    },
    {
        "olivercederborg/poimandres.nvim"
    },
    {
        'nyoom-engineering/oxocarbon.nvim',
        build = false,
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "vague-theme/vague.nvim",
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            -- Custom highlights are wiped whenever the colorscheme reloads (e.g. on a light/dark switch)
            local function custom_highlights()
                -- XXX: hi Normal ctermbg=NONE
                -- Make comments more prominent -- they are important.
                local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
                -- Remove background (Not working in WSL)
                for _, group in ipairs({ "Normal", "NormalNC", "SignColumn", "EndOfBuffer" }) do
                    vim.api.nvim_set_hl(0, group, { fg = vim.api.nvim_get_hl(0, { name = group, link = false }).fg, bg = "none" })
                end
                -- Uncomment if you want the floating window to be bg less
                -- vim.api.nvim_set_hl(0, "normalfloat", { bg = "none" })
                -- Make it clearly visible which argument we're at.
                local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
                vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter',
                    { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
                -- Remove background color
                -- Optional: customize line number highlight
                vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = "#7aa2f7", bold = true })
            end
            vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", callback = custom_highlights })

            vim.o.background = 'dark' -- fallback if theme-switch hasn't written a mode yet
            require("theme").setup()
            vim.cmd("colorscheme tokyonight")

            -- Enable cursorline only for line number
            vim.opt.cursorline = true
            vim.opt.cursorlineopt = "number"
        end
    },
    -- 	config = function()
    --         vim.cmd('colorscheme tokyodark')
    -- 	end
    -- },
    -- nice bar at the bottom
    {
        'itchyny/lightline.vim',
        lazy = false, -- also load at start since it's UI
        colorscheme = "powerline",
        config = function()
            -- no need to also show mode in cmd line when we have bar
            vim.o.showmode = false
            vim.g.lightline = {
                active = {
                    left = {
                        { 'mode' },
                        { 'filename' },
                        { 'gitbranch' },
                    },
                    right = {
                        { 'lineinfo' },
                        { 'percent' },
                        { 'fileencoding', 'filetype' }
                    },
                },
                component_function = {
                    gitbranch = 'FugitiveHead',
                },
            }
            function LightlineFilenameInLua(opts)
                if vim.fn.expand('%:t') == '' then
                    return '[No Name]'
                else
                    return vim.fn.getreg('%')
                end
            end
        end
    },
}

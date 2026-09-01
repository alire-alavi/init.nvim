return { 
    {
        'shaunsingh/nord.nvim'
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "vague-theme/vague.nvim",
    },
    { 
        "catppuccin/nvim", 
        priority = 1000,
        config = function() 
            vim.cmd("colorscheme habamax")
	        vim.o.background = 'dark'
	 		-- XXX: hi Normal ctermbg=NONE
	 		-- Make comments more prominent -- they are important.
	 		local bools = vim.api.nvim_get_hl(0, { name = 'Boolean'})
            -- Remove background (Not working in WSL)
            vim.api.nvim_set_hl(0, "normal", { bg = "none" })
            -- Uncomment if you want the floating window to be bg less
            -- vim.api.nvim_set_hl(0, "normalfloat", { bg = "none" })
	 		-- Make it clearly visible which argument we're at.
	 		local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
	 		vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
            -- Enable cursorline only for line number
            vim.opt.cursorline = true
            vim.opt.cursorlineopt = "number"
            -- Remove background color
            -- Optional: customize line number highlight
            vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none",  fg = "#7aa2f7", bold = true })
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

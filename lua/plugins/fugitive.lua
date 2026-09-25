return { 
    'tpope/vim-fugitive',
    config =  function ()
        -- nnoremap <leader>gs :Git ++curwin<CR>
        vim.keymap.set("n", "<leader>gs", "<cmd>Git ++curwin<CR>", { desc = "Fugitive status (same window)" })
    end
}


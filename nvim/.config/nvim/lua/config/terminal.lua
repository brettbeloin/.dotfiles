vim.api.nvim_create_autocmd({ 'BufEnter', 'TermEnter', 'TermLeave' }, {
    desc = 'cd to terminal cwd on enter',
    pattern = 'term://*',
    callback = function()
        local pid = vim.b.terminal_job_pid
        if not pid then return end

        local cwd = vim.fn.resolve('/proc/' .. pid .. '/cwd')
        if vim.fn.isdirectory(cwd) == 0 then return end
        vim.fn.chdir(cwd)
    end,
})

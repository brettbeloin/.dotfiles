local vi = vim
vi.opt.number = true
vi.opt.relativenumber = true
vi.opt.cursorline = true
vi.o.tabstop = 4
vi.o.shiftwidth = 4
vi.o.expandtab = true
vi.o.softtabstop = 4
vi.opt.swapfile = false
vi.opt.termguicolors = true
vi.opt.shell = "/usr/bin/bash"
vi.cmd.colorscheme("everforest")

vi.diagnostic.config({
    virtual_text = true, -- Set to false to hide inline messages
    signs = true,
})

vi.api.nvim_create_autocmd({ 'BufEnter', 'TermEnter', 'TermLeave' }, {
    desc = 'cd to terminal cwd on enter',
    pattern = 'term://*',
    callback = function()
        local pid = vi.b.terminal_job_pid
        if not pid then return end

        local cwd = vi.fn.resolve('/proc/' .. pid .. '/cwd')
        if vi.fn.isdirectory(cwd) == 0 then return end
        vi.fn.chdir(cwd)
    end,
})

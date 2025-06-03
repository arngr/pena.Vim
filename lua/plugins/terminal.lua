return {
    {
        "akinsho/toggleterm.nvim",
        config = function()
            local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
            local shell = is_windows and (vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell") or "zsh"

            require("toggleterm").setup({
                size = function(term)
                    return math.floor(vim.o.lines * 0.25)
                end,
                on_exit = function(term, job_exit_code, _)
                    if job_exit_code == 0 then
                        vim.schedule(function()
                            vim.cmd("bd! " .. term.bufnr) -- force close terminal buffer
                        end)
                    else
                        print("Process exited with code " .. job_exit_code)
                    end
                end,
                persist_size = true, -- keep the size consistent between sessions
                shell = shell,
            })
        end,
    },
}

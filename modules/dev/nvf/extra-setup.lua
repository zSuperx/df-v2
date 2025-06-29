vim.api.nvim_create_user_command("F",
    function(args)
        vim.lsp.buf.format()
    end
    , {
        nargs = 0,
        desc = "Format file using built-in formatter",
    })

vim.api.nvim_create_user_command("Fw",
    function(args)
        vim.lsp.buf.format()
        vim.cmd("w", args)
    end
    , {
        nargs = 0,
        desc = "Format file using built-in formatter",
    })

vim.api.nvim_create_user_command("FW",
    function(args)
        vim.lsp.buf.format()
        vim.cmd("w", args)
    end
    , {
        nargs = 0,
        desc = "Format file using built-in formatter",
    })

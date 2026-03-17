return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
            "jay-babu/mason-nvim-dap.nvim",
        },
        keys = {
            { "<F5>",       function() require("dap").continue() end,          desc = "DAP: Continue" },
            { "<F10>",      function() require("dap").step_over() end,         desc = "DAP: Step over" },
            { "<F11>",      function() require("dap").step_into() end,         desc = "DAP: Step into" },
            { "<F12>",      function() require("dap").step_out() end,          desc = "DAP: Step out" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
            { "<leader>du", function() require("dapui").toggle() end,          desc = "DAP: Toggle UI" },
            { "<leader>dr", function() require("dap").repl.open() end,         desc = "DAP: REPL" },
        },
        config = function()
            local dap    = require("dap")
            local dapui  = require("dapui")

            require("mason-nvim-dap").setup({
                ensure_installed    = { "python", "codelldb" },
                automatic_installation = true,
            })

            require("dap-python").setup(
                vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
            )

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                    args    = { "--port", "${port}" },
                },
            }
            for _, lang in ipairs({ "c", "cpp", "rust" }) do
                dap.configurations[lang] = {{
                    name        = "Launch",
                    type        = "codelldb",
                    request     = "launch",
                    program     = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd         = "${workspaceFolder}",
                    stopOnEntry = false,
                }}
            end

            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"]  = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end
        end,
    },
}

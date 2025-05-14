-- LSP configs
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local server_list = { "denols", "ruff", "rust_analyzer", "sourcekit", "zls" }
for _, value in pairs(server_list) do
    vim.lsp.enable(value)
    vim.lsp.config(value, {
        capabilities = capabilities,
    })
end

local elixir_path = vim.fn.exepath("elixir-ls")
if string.len(elixir_path) ~= 0 then
    vim.lsp.enable("elixirls")
    vim.lsp.config("elixirls", {
        capabilities = capabilities,
        cmd = { elixir_path },
    })
end

if vim.fn.executable("gopls") == 1 then
    vim.lsp.enable("gopls")
    vim.lsp.config("gopls", {
        cmd = { "gopls" },
        capabilities = capabilities,
        settings = {
            gopls = {
                experimentalPostfixCompletions = true,
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
            },
        },
        init_options = {
            usePlaceholders = true,
        },
    })
end

if vim.fn.executable("lua-language-server") == 1 then
    vim.lsp.enable("lua_ls")
    vim.lsp.config("lua_ls", {
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = {
                        "vim",
                    },
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
            })
        end,
        settings = {
            Lua = {},
        },
    })
end

if vim.fn.executable("ruby-lsp") == 1 then
    vim.lsp.enable("ruby_lsp")
    vim.lsp.config("ruby_lsp", {
        capabilities = capabilities,
        init_options = {
            formatter = "standard",
            linters = { "standard" },
        },
    })
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float, { desc = "Open diagnostic in float" })
vim.keymap.set("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Put diagnostic in loclist" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to symbol declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to symbol definition" })
        vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            { buffer = ev.buf, desc = "List all references to symbol in buffer" }
        )
        vim.keymap.set(
            "n",
            "gt",
            vim.lsp.buf.type_definition,
            { buffer = ev.buf, desc = "Jump to symbol type definition" }
        )
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Display hover info for symbol" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to symbol implementation" })
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Display signature help" })
        vim.keymap.set(
            "n",
            "<leader>wa",
            vim.lsp.buf.add_workspace_folder,
            { buffer = ev.buf, desc = "Add folder to workspace used by lsp" }
        )
        vim.keymap.set(
            "n",
            "<leader>wr",
            vim.lsp.buf.remove_workspace_folder,
            { buffer = ev.buf, desc = "Remove folder to workspace used by lsp" }
        )
        vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = ev.buf, desc = "List lsp workspace folders" })
        vim.keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            { buffer = ev.buf, desc = "Rename all references to symbol" }
        )
        vim.keymap.set(
            { "n", "v" },
            "<space>ca",
            vim.lsp.buf.code_action,
            { buffer = ev.buf, desc = "Select an available code action" }
        )
        vim.keymap.set("n", "<leader>fl", function()
            vim.lsp.buf.format({ async = true })
        end, { buffer = ev.buf, desc = "Format buffer using lsp" })
    end,
})

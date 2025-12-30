local servers = {
	-- vimls = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
			},
		},
	},
	ts_ls = {
		init_options = {
			preferences = {
				importModuleSpecifier = "non-relative",
				importModuleSpecifierPreference = "non-relative",
			},
		},
	},
	biome = {},
	gopls = {},
}

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		lazy = false,
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"williamboman/mason.nvim",
		},
		lazy = false,
		config = function()
			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = false,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			for server_name, server_config in pairs(servers) do
				server_config.capabilities =
					vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})

				vim.lsp.config(server_name, server_config)
				vim.lsp.enable(server_name)
			end

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<M-r>", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<M-l>", function()
				local filetype = vim.bo.filetype

				if filetype == "javascript" or filetype == "typescript" or filetype == "typescriptreact" then
					vim.lsp.buf.code_action({
						apply = true,
						context = {
							only = { "source.organizeImports.biome" },
							diagnostics = {},
						},
					})
				else
					vim.lsp.buf.code_action({
						apply = true,
						context = {
							only = { "source.organizeImports" },
							diagnostics = {},
						},
					})
				end

				vim.lsp.buf.format({ async = false })
			end)
		end,
	},
}

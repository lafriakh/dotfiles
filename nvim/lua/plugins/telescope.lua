return {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = "v0.2.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<M-o>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
			vim.keymap.set("n", "<M-S-f>", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
			-- for fuzzy finding document symbols
			vim.keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
			vim.keymap.set(
				"n",
				"<M-C-o>",
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				{ desc = "Project Symbols" }
			)
			vim.keymap.set("n", "<M-h>", "<cmd>Telescope undo<cr>")
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action({
					filter = function(action)
						return action.title ~= "Convert named imports to namespace import"
					end,
				})
			end, { desc = "Code Action" })

			-- Setup
			telescope.setup({
				pickers = {
					buffers = {
						initial_mode = "normal", -- 👈 start in normal mode for buffers picker
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}

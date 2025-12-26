return {
	"smoka7/hop.nvim",
	version = "*",                    -- Use the stable version
	opts = {
		keys = "etovxqpdygfblzhckisuran", -- Custom label keys (optional)
	},
	config = function(_, opts)
		require("hop").setup(opts)

		vim.keymap.set("n", "f", ":HopWord<CR>", { desc = "Hop Word" })
	end,
}

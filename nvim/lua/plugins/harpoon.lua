return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({})

		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local finder = function()
				local paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(paths, item.value)
				end

				return require("telescope.finders").new_table({
					results = paths,
				})
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Marked files",
					finder = finder(),
					-- previewer = conf.file_previewer({}),
					layout_config = {
						width = 80, -- Set the width to exactly 80 characters
						height = 0.5, -- You can also set height in lines or percentage
					},
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						map("n", "dd", function()
							local state = require("telescope.actions.state")
							local selected_entry = state.get_selected_entry()
							local current_picker = state.get_current_picker(prompt_bufnr)

							table.remove(harpoon_files.items, selected_entry.index)
							current_picker:refresh(finder())
						end)
						return true
					end,
				})
				:find()
		end

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<M-S-O>", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open marked files window" })
	end,
}

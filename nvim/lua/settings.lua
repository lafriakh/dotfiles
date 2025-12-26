--vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = "," -- <space> is my leader key
-- =========================== VIM OPTIONS ===========================
vim.opt.number = true

-- show a thin highlight on the line number ONLY
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number" -- don't highlight the whole line, just the nr

-- Copy/paste to system clipboard
vim.opt.clipboard = "unnamedplus"

-- Save undo history to a file automatically
vim.opt.undofile = true

-- highlighting while yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Navigate in quicklist using <Command>+{j|k}
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>zz", { desc = "Next Quickfix Item" })
		vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>zz", { desc = "Prev Quickfix Item" })

		-- Remap arrow keys in normal mode for quickfix navigation
		vim.keymap.set("n", "<Up>", ":cprev<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<Down>", ":cnext<CR>", { noremap = true, silent = true })
	end,
})

-- Start terminal mode when terminal buffer open.
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.cmd("startinsert!")
	end,
})

-- Navigate diagnostics
vim.keymap.set("n", "<leader>n", function()
	vim.diagnostic.jump({ count = 1 })
	vim.schedule(function()
		vim.diagnostic.open_float({ border = "rounded", focusable = true })
	end)
end, { desc = "Next Diagnostic" })

-- =========================== GLOBAL KEYMAPS ===========================
-- Note: there are individual keymaps that have been set in the plugins
-- as well, such as in the lsp-config.lua and git.lua files.
-- This file is for global keymaps that are not specific to any plugin.
--
-- Keys:
-- <C-...> = Ctrl + ... (e.g. <C-s> = Ctrl + s)
-- <CR> = Enter key
-- <cmd> = Command mode, same as using the colon (e.g. <cmd>q<CR> = :q<CR>)

local keymap = vim.keymap.set

-- Reload the configuration
keymap("n", "<Leader><Leader>s", "<cmd>source %<CR>", { desc = "Source the changes in the neovim config" })

-- Exit insert/visual mode with jk/jj
keymap("i", "jk", "<Esc>", { desc = "Exit insert mode with 'jk'" })
keymap("i", "jj", "<Esc>", { desc = "Exit insert mode with 'jk'" })

-- Save the changes
keymap("n", "<leader>s", ":write!<CR>", { desc = "Save the changes" })

-- staying in indent mode
keymap("v", ">", ">gv", { desc = "Indent right and stay in visual mode" })
keymap("v", "<", "<gv", { desc = "Indent left and stay in visual mode" })

-- moving text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected text down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected text up" })

-- Better split switching
keymap("", "<C-j>", "<C-W>j")
keymap("", "<C-k>", "<C-W>k")
keymap("", "<C-h>", "<C-W>h")
keymap("", "<C-l>", "<C-W>l")

-- Close buffer
vim.keymap.set({ "n", "i", "v" }, "<M-w>", "<cmd>bd<CR>", { desc = "Close Buffer" })

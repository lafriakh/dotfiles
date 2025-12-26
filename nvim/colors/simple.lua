-- Clear existing highlights
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "simple"

-- 1. Detect Mode (Light vs Dark)
local is_dark = vim.o.background == "dark"

-- 2. Define Palette based on mode
local bg = is_dark and "#000000" or "#ffffff"
local fg = is_dark and "#ffffff" or "#000000"
local visual = is_dark and "#333333" or "#e0e0e0" -- Dark grey vs Light grey selection
local line_nr = is_dark and "#444444" or "#a0a0a0"
local cursor = is_dark and "#222222" or "#f5f5f5"

-- Brown adjustment: #8b4513 is too dark for black backgrounds.
-- We use a lighter brown (#cd853f) for dark mode to ensure readability.
local brown = is_dark and "#cd853f" or "#8b4513"

local function set_hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

-- 3. Base Editor
set_hl("Normal", { fg = fg, bg = bg })
set_hl("LineNr", { fg = line_nr, bg = bg })
set_hl("CursorLine", { bg = cursor })
set_hl("Visual", { bg = visual })
set_hl("Pmenu", { fg = fg, bg = visual })
set_hl("PmenuSel", { fg = bg, bg = fg, bold = true }) -- Inverted for menu selection
set_hl("MatchParen", { bg = visual, bold = true })
set_hl("Search", { bg = "#ffff00", fg = "#000000" }) -- Keep search yellow/black (high contrast)

-- 4. The "Monochrome" Logic
-- Force everything to be the foreground color (White or Black)
local groups_to_fg = {
	"String",
	"Character",
	"Number",
	"Boolean",
	"Float",
	"Identifier",
	"Function",
	"Statement",
	"Conditional",
	"Repeat",
	"Label",
	"Operator",
	"Keyword",
	"Exception",
	"PreProc",
	"Include",
	"Define",
	"Macro",
	"PreCondit",
	"Type",
	"StorageClass",
	"Structure",
	"Typedef",
	"Special",
	"SpecialChar",
	"Tag",
	"Delimiter",
	"Debug",
	"Constant",
	"Title",
}

for _, group in ipairs(groups_to_fg) do
	set_hl(group, { fg = fg })
end

-- 5. The Exception: Comments are Brown
set_hl("Comment", { fg = brown, italic = true })

-- 6. TreeSitter Overrides
-- Ensure TreeSitter links everything to our monochrome groups or Comment
local ts_links = {
	["@variable"] = "Identifier",
	["@property"] = "Identifier",
	["@function"] = "Function",
	["@keyword"] = "Keyword",
	["@string"] = "String",
	["@type"] = "Type",
	["@punctuation"] = "Operator",
	["@constructor"] = "Function",
	["@tag"] = "Keyword",
	["@tag.attribute"] = "Identifier",
	["@comment"] = "Comment", -- Keeps comments brown
}

for src, dest in pairs(ts_links) do
	vim.api.nvim_set_hl(0, src, { link = dest })
end

local tmuxline_theme = {
	-- Left Side
	a = { fg, visual, "bold" }, -- Session: BG text on Brown
	b = { fg, visual }, -- Info: FG text on Visual Grey
	c = { fg, bg }, -- Main Bar: FG text on BG

	-- Right Side
	x = { fg, visual },
	y = { fg, visual },
	z = { fg, visual, "bold" }, -- Host: BG text on Brown

	-- Windows
	win = { fg, bg }, -- Inactive: Grey text on BG
	cwin = { bg, fg, "bold" }, -- Active: BG text on FG (Inverted)
	bg = { fg, bg },
}

vim.g.simple_tmuxline_palette = tmuxline_theme

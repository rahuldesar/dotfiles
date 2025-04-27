require("rahul_config.custom.cheat")
require("rahul_config.custom.quicknote")
require("rahul_config.custom.tts")

-- custom macros --
-- NOTE: this can be replaced using keymap but this is just for testing
-- ALSO: this doesn't work, just use `sort` bro
vim.fn.setreg("s", [[:sort<CR>]], "c")

-- Open google search
local config = {
	default_engine = "google",
	query_map = {
		bing = "https://cn.bing.com/search?q=%s",
		duckduckgo = "https://duckduckgo.com/?q=%s",
		google = "https://www.google.com/search?q=%s",
		wikipedia = "https://en.wikipedia.org/w/index.php?search=%s",
	},
}

local function looks_like_url(input)
	local pat = "[%w%.%-]+%.[%w%.%-_/]+"
	return input:match(pat) ~= nil
end

local function extract_prefix(input)
	local pat = "@(%w+)"
	local prefix = input:match(pat)
	if not prefix or not config.query_map[prefix] then
		return vim.trim(input), config.default_engine
	end
	local query = input:gsub("@" .. prefix, "")
	return vim.trim(query), prefix
end

local function query_browser(input)
	local q, prefix = extract_prefix(input)
	if not looks_like_url(input) then
		local format = config.query_map[prefix]
		q = format:format(vim.uri_encode(q))
	end
	vim.ui.open(q)
end

vim.keymap.set("n", "<leader>b", function()
	vim.ui.input({ prompt = "Search: " }, function(input)
		if input then
			query_browser(input)
		end
	end)
end)

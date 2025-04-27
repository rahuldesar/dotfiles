-- clipboard `*` register because getting word for visual mode selection '<,>' is painful
vim.keymap.set("n", "<leader>ts", function()
	local yanked_text = vim.fn.getreg("*")
	if yanked_text == "" then
		print("No text in clipboard register!")
		return
	end

	local tmpfile = "/tmp/tts_input.txt"
	-- INFO: `audiogen_en` creates this file `<filename>/<filename_combined>.mp3`
	local outfile = "/tmp/tts_input/tts_input_combined.mp3"

	vim.fn.writefile(vim.split(yanked_text, "\n"), tmpfile)
	vim.notify("TTS generation started. \n-------------------------\n" .. yanked_text, vim.log.levels.INFO)
	vim.fn.jobstart("/Users/rahuldesar/scripts/audiogen_en " .. tmpfile .. " && afplay " .. outfile, { detach = true })
end, { desc = "TTS play clipboard register" })

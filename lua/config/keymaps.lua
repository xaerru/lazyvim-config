-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local betterTerm = require("betterTerm")
-- toggle firts term
vim.keymap.set({ "n", "t" }, "<C-t>", betterTerm.open, { desc = "Open terminal" })
-- Select term focus
vim.keymap.set({ "n" }, "<leader>tt", betterTerm.select, { desc = "Select terminal" })
-- Create new term
local current = 2
vim.keymap.set({ "n" }, "<leader>tn", function()
  betterTerm.open(current)
  current = current + 1
end, { desc = "New terminal" })

vim.keymap.set("n", "<leader>rf", ":RunCode<CR>", { noremap = true, silent = false, desc = "Run File" })
vim.keymap.set("n", "<leader>rr", ":CompetiTest run<CR>", { noremap = true, silent = false, desc = "CP run" })
vim.keymap.set(
  "n",
  "<leader>ra",
  ":CompetiTest add_testcase<CR>",
  { noremap = true, silent = false, desc = "CP add testcase" }
)
vim.keymap.set(
  "n",
  "<leader>rd",
  ":CompetiTest delete_testcase<CR>",
  { noremap = true, silent = false, desc = "CP delete testcase" }
)
vim.keymap.set(
  "n",
  "<leader>re",
  ":CompetiTest edit_testcase<CR>",
  { noremap = true, silent = false, desc = "CP edit testcase" }
)
vim.keymap.set(
  "n",
  "<leader>rc",
  ":CompetiTest receive problem <CR>",
  { noremap = true, silent = false, desc = "CP receive problem" }
)

local hop = require("hop")
vim.keymap.set("", "f", function()
  hop.hint_char2({})
end, { remap = true })
vim.keymap.set("", "gl", function()
  hop.hint_lines_skip_whitespace({})
end, { remap = true })
vim.keymap.set("", "gw", function()
  hop.hint_words({})
end, { remap = true })

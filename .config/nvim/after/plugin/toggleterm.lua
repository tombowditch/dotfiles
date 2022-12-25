local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = 10,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = false,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  autochdir = true,
  highlights = {
    NormalFloat = {
      link = "Normal",
    },
    FloatBorder = {
      link = "FloatBorder",
    },
  },
  float_opts = {
    border = "rounded",
    winblend = 0,
  },
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new { cmd = "lazygit", hidden = true }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin",
    opts = {
      transparent_background = true,
    },
    init = function()
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },
}

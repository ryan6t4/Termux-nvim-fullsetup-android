-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[
  augroup SpellCheck
    autocmd!
    autocmd FileType markdown,text,gitcommit setlocal spell spelllang=en_us
  augroup END
]])

vim.g.python3_host_prog = "/home/jonas/.venvs/nvim/bin/python3"

vim.cmd("source ~/.config/nvim/myinit.vim")

require("ollama").setup({})

vim.keymap.set({ "n", "v" }, "<leader>oo", function()
  require("ollama").prompt()
end)

require('nvim-eslint').setup({})

-- Re-enable Python provider & set host
-- Enable providers (must run early)
vim.g.loaded_python3_provider = nil
vim.g.loaded_node_provider = nil
vim.g.loaded_ruby_provider = nil
vim.g.loaded_perl_provider = 0
--vim.cmd('runtime autoload/provider/python3.vim')


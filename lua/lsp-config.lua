local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local util = require 'lspconfig.util'

mason.setup()

lspconfig.ccls.setup({
  on_attach = on_attach,
  single_file_support = true,
  root_dir = function(fname)
    return util.root_pattern('compile_commands.json', '.ccls')(fname) or util.find_git_ancestor(fname) or vim.fn.getcwd()
  end,
  init_options = {
    compilationDatabaseDirectory = "",
    cache = {
      directory = ".ccls-cache"
    },
    index = {
      threads = 32;
    },
    clang = {
      extraArgs = { 
        "-I/usr/include", 
        "-I/usr/local/include", 
        "-I/usr/include/c++/13",
      },
      resourceDir = ""
    }
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  filetypes = { "c", "cpp", "h", "hpp" },
})

cmp.setup({
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})


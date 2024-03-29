local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')
local languages = require('plugin.lsp.format')
local on_attach_common = require('plugin.lsp.on-attach')

-- Customize diagnostics signs
local function set_sign(type, icon)
  local sign = string.format("LspDiagnosticsSign%s", type)
  local texthl = string.format("LspDiagnosticsDefault%s", type)
  vim.fn.sign_define(sign, {text = icon, texthl = texthl})
end

-- Customize diagnostics highlights
local function set_highlight(type, color)
  vim.cmd(string.format("highlight! LspDiagnosticsDefault%s guifg=%s", type, color))
end

-- Check if a eslint config is present
local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if pcall(vim.fn.filereadable("package.json")) then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

_G.formatting = function()
  if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
    vim.lsp.buf.formatting(vim.g[string.format("format_options_%s", vim.bo.filetype)] or {})
  end
end

set_sign("Hint", "")
set_sign("Information", "")
set_sign("Warning", "")
set_sign("Error", "ﰸ")

set_highlight("Hint", '#30d130')
set_highlight("Information", '#30d130')
set_highlight("Warning", '#f5ee27')
set_highlight("Error", '#f52727')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {'documentation', 'detail', 'additionalTextEdits'},
}


-- configuring diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false, -- disable inline diagnostics
    signs = true,
    update_in_insert = false,
  }
)


local function setup_servers()
  lspinstall.setup()
  local installed = lspinstall.installed_servers()
  for _, server in pairs(installed) do
    local config = {root_dir = lspconfig.util.root_pattern({'.git/', '.'})}
    capabilities = capabilities
    config.on_attach = on_attach_common
    lspconfig[server].setup(config)
  end


  -- Efm language server
  -- https://github.com/mattn/efm-langserver
  lspconfig.efm.setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = true
      on_attach_common(client)
    end,
    init_options = {documentFormatting = true, codeAction = true, document_formatting = true},
    root_dir = lspconfig.util.root_pattern({'.git/', '.'}),

    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "less",
        "scss",
        "css"
    },
    settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
  }

  -- Lua language server
  -- local system_name
  if vim.fn.has("mac") == 1 then
    system_name = "macOS"
  elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
  elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
  else
    print("Unsupported system for sumneko")
  end

  local sumneko_root_path = '/Users/jonwalstedt/repos/language-servers/lua/lua-language-server'
  local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
  lspconfig.sumneko_lua.setup({
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { "vim" },
        },
      }
    },

    on_attach = on_attach_common
  })

  -- Typescript languageserver
  -- https://github.com/theia-ide/typescript-language-server
  lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      client.resolved_capabilities.document_formatting = false
      on_attach_common(client)
    end
  }

  -- Go languageserver
  -- https://github.com/golang/tools/tree/master/gopls
  lspconfig.gopls.setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach_common(client)
    end
  }

  -- Python languageserver
  -- https://github.com/palantir/python-language-server
  lspconfig.pyls.setup {
    on_attach = on_attach_common,
    settings = {
      pyls = {
        plugins = {
          pycodestyle = {
            enabled = false,
            ignore = {
              "E501"
            }
          }
        }
      }
    }
  }

  lspconfig.pyright.setup {on_attach = on_attach_common}

  -- Vim languageserver
  -- https://github.com/iamcco/vim-language-server
  lspconfig.vimls.setup {on_attach = on_attach_common}

  -- Docker languageserver
  -- https://github.com/rcjsuen/dockerfile-language-server-nodejs
  lspconfig.dockerls.setup {on_attach = on_attach_common}

  -- Terraform languageserver
  -- https://github.com/hashicorp/terraform-ls
  lspconfig.terraformls.setup {
    on_attach = on_attach_common,
    cmd = {"terraform-ls", "serve"},
    filetypes = {"tf"}
  }

  -- CSS languageserver
  -- https://github.com/vscode-langservers/vscode-css-languageserver-bin
  lspconfig.cssls.setup{
    on_attach = on_attach_common,
    capabilities = capabilities,
    cmd = { "html-languageserver", "--stdio" },
    filetypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      }
    },
    settings = {},
  }
end

setup_servers()

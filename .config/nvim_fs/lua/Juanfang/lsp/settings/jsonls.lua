local schemas = {
  {
    description = "TypeScript compiler configuration file",
    fileMatch = {
      "tsconfig.json",
      "tsconfig.*.json",
    },
    url = "https://json.schemastore.org/tsconfig.json",
  },
  {
    description = "Json schema for properties json file for a GitHub Workflow template",
    fileMatch = {
      ".github/Workflow-templates/**.properties.json",
    },
    url = "https://json.schemastore.org/github-workflow-template-properties.json",
  },
  {
    description = "NPM configuration file",
    fileMatch = {
      "package.json",
    },
    url = "https://json.schemastore.org/package.json",
  },
  {
    description = "docker compose configuration file",
    fileMatch = {
      "docker-compose.yml",
      "docker-compose*.yml",
    },
    url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
  },
  {
    description = "eslint configuration file",
    fileMatch = {
      ".eslintrc.json"
    },
    url = "https://json.schemastore.org/eslintrc.json"
  }
}

local opts = {
  cmd = { "vscode-json-language-server", "--stdio" },
  settings = {
    json = {
      schemas = schemas,
    },
  },
  setup = {
    commands = {
      Format = {
        function ()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}

return opts

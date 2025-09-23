return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- Default to fast local model for quick edits
    provider = "openai",

    -- OpenAI config (for complex reasoning)
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",
        timeout = 30000,
        max_tokens = 8192,
      },

      -- Ollama config for local models
      ollamalocal = {
      __inherited_from = "openai",
      api_key_name = "",
        keep_alive = -1,
      endpoint = "http://localhost:11434/v1",
        model = "qwen2.5-coder:7b", -- Fast model for quick edits
        timeout = 10000,            -- Shorter timeout for local
      extra_request_body = {
        options = {
          temperature = 0,
        }
      },
      mode = "legacy",
          max_tokens = 4096,
    }
    },

    -- Dynamic system prompts based on context
    system_prompt = function()
      local filetype = vim.bo.filetype
      local filename = vim.fn.expand "%:t"
      local project_type = detect_project_type()

      -- Base prompt with project context
      local base_prompt = string.format(
        [[
You are an expert %s developer working on a %s project.
Current file: %s
Always write clean, maintainable code following best practices.
]],
        get_stack_description(project_type),
        project_type,
        filename
      )

      -- File type specific additions
      local filetype_prompts = {
        typescript = [[
- Use strict TypeScript with proper type annotations
- Prefer interfaces over types when possible
- Use modern ES6+ features and async/await
- Include proper error handling
- Follow functional programming patterns where appropriate
]],
        typescriptreact = [[
- Use functional React components with TypeScript
- Implement proper prop interfaces with JSDoc
- Use React hooks following best practices
- Include proper key props for lists
- Use Tailwind CSS for styling
- Consider performance (useMemo, useCallback when needed)
]],
        javascript = [[
- Use modern JavaScript (ES6+) features
- Implement proper error handling with try/catch
- Use async/await over promises when possible
- Include JSDoc comments for functions
- Follow consistent naming conventions
]],
        sql = [[
- Write efficient, readable SQL queries
- Use proper table aliases and meaningful names
- Include appropriate indexes in suggestions
- Use parameterized queries for security
- Add comments explaining complex logic
]],
        json = [[
- Ensure valid JSON syntax
- Use consistent formatting and indentation
- Include meaningful property names
- Consider schema validation if applicable
]],
        lua = [[
- Follow Neovim Lua conventions
- Use proper module structure with return tables
- Include error handling for vim API calls
- Use descriptive variable names
- Consider performance for frequently called functions
]],
      }

      -- Project-specific additions
      local project_prompts = {
        ["react-frontend"] = [[
- Focus on component reusability and composition
- Consider accessibility (ARIA labels, semantic HTML)
- Implement proper state management patterns
- Use React Query for data fetching when appropriate
- Consider mobile responsiveness
]],
        ["express-backend"] = [[
- Implement proper middleware patterns
- Use appropriate HTTP status codes
- Include request validation and sanitization
- Implement proper error handling middleware
- Consider rate limiting and security headers
]],
        ["fullstack-typescript"] = [[
- Ensure type safety across frontend and backend
- Share types between client and server when possible
- Implement proper API contracts
- Consider data validation on both ends
]],
        ["database"] = [[
- Design for scalability and performance
- Consider data relationships and normalization
- Implement proper indexes for query optimization
- Include migration strategies for schema changes
]],
      }

      -- Context-specific additions based on filename patterns
      local context_prompts = {
        ["test"] = [[
- Write comprehensive test cases covering edge cases
- Use descriptive test names explaining what is being tested
- Include setup and teardown where appropriate
- Mock external dependencies properly
]],
        ["config"] = [[
- Ensure configuration is environment-aware
- Include proper validation for required settings
- Consider security implications of configuration values
- Use clear, documented configuration structure
]],
        ["api"] = [[
- Design RESTful endpoints with proper HTTP methods
- Implement consistent error response formats
- Include proper request/response validation
- Consider rate limiting and authentication
]],
        ["component"] = [[
- Design for reusability and composition
- Implement proper prop validation
- Consider component lifecycle and cleanup
- Include proper accessibility attributes
]],
      }

      -- Build the complete prompt
      local prompt = base_prompt

      -- Add filetype-specific prompt
      if filetype_prompts[filetype] then
        prompt = prompt
            .. "\nFile Type Guidelines:\n"
            .. filetype_prompts[filetype]
      end

      -- Add project-specific prompt
      if project_prompts[project_type] then
        prompt = prompt
            .. "\nProject Guidelines:\n"
            .. project_prompts[project_type]
      end

      -- Add context-specific prompt based on filename
      for pattern, context_prompt in pairs(context_prompts) do
        if string.find(filename:lower(), pattern) then
          prompt = prompt .. "\nContext Guidelines:\n" .. context_prompt
          break
        end
      end

      return prompt
    end,

    -- Custom key mappings
    mappings = {
      ask = "<leader>aa",
      edit = "<leader>ae",
      chat = "<leader>ac",
    },
  },

  -- Build configuration
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    "HakonHarnes/img-clip.nvim",
  },

  -- Custom configuration function
  config = function(_, opts)
    -- Helper functions for context detection
    function detect_project_type()
      local cwd = vim.fn.getcwd()
      local package_json = cwd .. "/package.json"
      local tsconfig = cwd .. "/tsconfig.json"

      -- Check if package.json exists and analyze dependencies
      if vim.fn.filereadable(package_json) == 1 then
        local package_content = vim.fn.readfile(package_json)
        local package_str = table.concat(package_content, "\n")

        if
            string.find(package_str, "react")
            and string.find(package_str, "express")
        then
          return "fullstack-typescript"
        elseif string.find(package_str, "react") then
          return "react-frontend"
        elseif string.find(package_str, "express") then
          return "express-backend"
        end
      end

      -- Check for TypeScript config
      if vim.fn.filereadable(tsconfig) == 1 then
        return "typescript-project"
      end

      -- Check for database files
      if
          vim.fn.glob(cwd .. "/*.sql") ~= ""
          or vim.fn.isdirectory(cwd .. "/migrations") == 1
      then
        return "database"
      end

      return "general"
    end

    function get_stack_description(project_type)
      local descriptions = {
        ["react-frontend"] = "React/TypeScript frontend",
        ["express-backend"] = "Express.js/Node.js backend",
        ["fullstack-typescript"] = "full-stack TypeScript",
        ["typescript-project"] = "TypeScript",
        ["database"] = "database/SQL",
        ["general"] = "software",
      }
      return descriptions[project_type] or "software"
    end

    require("avante").setup(opts)

    -- Store configurations for different providers
    local provider_configs = {
      openai = {
        provider = "openai",
        providers = {
          openai = opts.providers.openai
        }
      },
      ollama_fast = {
        provider = "ollama",
        providers = {
          ollamalocal = vim.tbl_deep_extend("force", opts.providers.ollamalocal, {
            model = "qwen2.5-coder:7b"
          })
        }
      },
      ollama_smart = {
        provider = "ollamalocal", 
        providers = {
          ollamalocal = vim.tbl_deep_extend("force", opts.providers.ollamalocal, {
            model = "qwen2.5-coder:14b"
          })
        }
      }
    }

    -- Commands to switch providers by reloading config
    vim.api.nvim_create_user_command("AvanteCloud", function()
      require("avante").setup(vim.tbl_deep_extend("force", opts, provider_configs.openai))
      vim.notify("Switched to OpenAI (Cloud) model", vim.log.levels.INFO)
    end, { desc = "Switch to OpenAI provider" })

    vim.api.nvim_create_user_command("AvanteLocalFast", function()
      require("avante").setup(vim.tbl_deep_extend("force", opts, provider_configs.ollama_fast))
      vim.notify("Switched to fast local model (7B)", vim.log.levels.INFO)
    end, { desc = "Switch to fast local Ollama model" })

    vim.api.nvim_create_user_command("AvanteLocalSmart", function()
      require("avante").setup(vim.tbl_deep_extend("force", opts, provider_configs.ollama_smart))
      vim.notify("Switched to smart local model (14B)", vim.log.levels.INFO)
    end, { desc = "Switch to smart local Ollama model" })

    -- Context-aware AI commands
    vim.api.nvim_create_user_command("AvanteExplain", function()
      local filetype = vim.bo.filetype
      local context = "Explain this "
          .. filetype
          .. " code in detail, including its purpose, how it works, and any potential improvements:"
      
      -- Get current visual selection or current line
      local start_line = vim.fn.line("'<")
      local end_line = vim.fn.line("'>")
      if start_line == 0 or end_line == 0 then
        start_line = vim.fn.line(".")
        end_line = start_line
      end
      
      local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
      local code = table.concat(lines, "\n")
      
      -- Open avante with context
      vim.cmd("AvanteAsk " .. context .. "\n\n```" .. filetype .. "\n" .. code .. "\n```")
    end, { desc = "Explain selected code with context" })

    vim.api.nvim_create_user_command("AvanteOptimize", function()
      local filetype = vim.bo.filetype
      local context = "Analyze this "
          .. filetype
          .. " code for performance optimizations, best practices, and potential issues:"
      
      local start_line = vim.fn.line("'<")
      local end_line = vim.fn.line("'>")
      if start_line == 0 or end_line == 0 then
        start_line = vim.fn.line(".")
        end_line = start_line
      end
      
      local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
      local code = table.concat(lines, "\n")
      
      vim.cmd("AvanteAsk " .. context .. "\n\n```" .. filetype .. "\n" .. code .. "\n```")
    end, { desc = "Optimize selected code" })

    -- Keymaps for quick provider switching
    vim.keymap.set("n", "<leader>ac", "<cmd>AvanteLocalFast<CR>")
    vim.keymap.set("n", "<leader>av", "<cmd>AvanteLocalSmart<CR>")
    vim.keymap.set("n", "<leader>ab", "<cmd>AvanteCloud<CR>")

    -- Context-aware commands
    vim.keymap.set("n", "<leader>a?", "<cmd>AvanteExplain<CR>")
    vim.keymap.set("v", "<leader>a?", "<cmd>AvanteExplain<CR>")
    vim.keymap.set("n", "<leader>ao", "<cmd>AvanteOptimize<CR>")
    vim.keymap.set("v", "<leader>ao", "<cmd>AvanteOptimize<CR>")
  end,
}

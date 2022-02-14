local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

local filetype_to_parsername = require"nvim-treesitter.parsers".filetype_to_parsername

for _, filetype in ipairs(require("jrasmusbm.filetypes").python) do
  if filetype ~= "python" then filetype_to_parsername["python"] = filetype end
end

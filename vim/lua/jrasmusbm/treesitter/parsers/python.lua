local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

for _, filetype in ipairs(require("jrasmusbm.filetypes").python) do
  if filetype ~= "python" then parser_config["python"]["used_by"] = filetype end
end

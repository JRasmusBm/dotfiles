local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config["python"]["used_by"]= "python.unittest"
parser_config["python"]["used_by"]= "python.pytest"

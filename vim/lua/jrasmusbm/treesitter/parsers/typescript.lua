local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config["typescript"]["used_by"]= "typescript.express"
parser_config["typescript"]["used_by"]= "typescript.express.typescript_mocha"
parser_config["typescript"]["used_by"]= "typescript.typescript_mocha"

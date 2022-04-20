local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[ packadd! vim-caser ]]

vim.g.caser_no_mappings = 1

local function case_pascal()
  mappings.nmap("<localleader>cp", "<Plug>CaserMixedCase")
  mappings.vmap("<localleader>cp", "<Plug>CaserVMixedCase")
end

local function case_camel()
  mappings.nmap("<localleader>cc", "<Plug>CaserCamelCase")
  mappings.vmap("<localleader>cc", "<Plug>CaserVCamelCase")
end

local function case_snake()
  mappings.nmap("<localleader>cs", "<Plug>CaserSnakeCase")
  mappings.vmap("<localleader>cs", "<Plug>CaserVSnakeCase")
end

local function case_upper()
  mappings.nmap("<localleader>cu", "<Plug>CaserUpperCase")
  mappings.vmap("<localleader>cu", "<Plug>CaserVUpperCase")
end

local function case_words_title()
  mappings.nmap("<localleader>cwt", "<Plug>CaserTitleCase")
  mappings.vmap("<localleader>cwt", "<Plug>CaserVTitleCase")
end

local function case_words_sentence()
  mappings.nmap("<localleader>cws", "<Plug>CaserSentenceCase")
  mappings.vmap("<localleader>cws", "<Plug>CaserVSentenceCase")
end

local function case_kebab_lower()
  mappings.nmap("<localleader>ckl", "<Plug>CaserKebabCase")
  mappings.vmap("<localleader>ckl", "<Plug>CaserVKebabCase")
end

local function case_kebab_title()
  mappings.nmap("<localleader>ckt", "<Plug>CaserTitleKebabCase")
  mappings.vmap("<localleader>ckt", "<Plug>CaserVTitleKebabCase")
end

local function case_dot()
  mappings.nmap("<localleader>cd", "<Plug>CaserDotCase")
  mappings.vmap("<localleader>cd", "<Plug>CaserVDotCase")
end

case_pascal()
case_camel()
case_snake()
case_upper()
case_words_title()
case_words_sentence()
case_kebab_lower()
case_kebab_title()
case_dot()

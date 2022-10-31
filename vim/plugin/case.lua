vim.g.caser_no_mappings = 1

local nmap = function(binding, command)
  vim.keymap.set({ "n" }, binding, function()
    require("jrasmusbm.utils").ensure_setup("vim-caser")

    require("jrasmusbm.utils.edit").feedkeys(command)
  end, {})
end

local vmap = function(binding, command)
  vim.keymap.set({ "v" }, binding, function()
    require("jrasmusbm.utils").ensure_setup("vim-caser")

    require("jrasmusbm.utils.edit").feedkeys(command)
  end, {})
end

local function case_pascal()
  nmap("<localleader>cp", "<Plug>CaserMixedCase")
  vmap("<localleader>cp", "<Plug>CaserVMixedCase")
end

local function case_camel()
  nmap("<localleader>cc", "<Plug>CaserCamelCase")
  vmap("<localleader>cc", "<Plug>CaserVCamelCase")
end

local function case_snake()
  nmap("<localleader>cs", "<Plug>CaserSnakeCase")
  vmap("<localleader>cs", "<Plug>CaserVSnakeCase")
end

local function case_title()
  nmap("<localleader>ct", "<Plug>CaserTitleCase")
  vmap("<localleader>ct", "<Plug>CaserVTitleCase")
end

local function case_words_sentence()
  nmap("<localleader>cw", "<Plug>CaserSentenceCase")
  vmap("<localleader>cw", "<Plug>CaserVSentenceCase")
end

local function case_kebab()
  nmap("<localleader>ck", "<Plug>CaserKebabCase")
  vmap("<localleader>ck", "<Plug>CaserVKebabCase")
  nmap("<localleader>cK", "<Plug>CaserTitleKebabCase")
  vmap("<localleader>cK", "<Plug>CaserVTitleKebabCase")
end

local function case_dot()
  nmap("<localleader>c.", "<Plug>CaserDotCase")
  vmap("<localleader>c.", "<Plug>CaserVDotCase")
end

case_pascal()
case_camel()
case_snake()
case_title()
case_words_sentence()
case_kebab()
case_dot()

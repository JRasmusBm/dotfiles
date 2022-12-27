vim.fn.setreg("n", "dt,nvgnpdf @n")
vim.fn.setreg("c", "/\\v\\%s\n$i,0l@n")

vim.keymap.set({ "n" }, "==", function()
  vim.cmd [[
    %!sqlformat - -k upper -r --indent_columns --indent_width 2
  ]]
end, { silent = true, buffer = 0 })

vim.keymap.set({ "n" }, ";c", "", {})
vim.g.VtrStripLeadingWhitespace = 0

vim.opt.formatprg = "sqlformat - -k upper -r --indent_columns --wrap_after 60"

local ls = require "luasnip"
local s = ls.s
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("sql", {
  s(
    { trig = "running", name = "get running queries" },
    fmt(
      [[
SELECT pid, now() - backend_start, query
FROM pg_stat_activity
WHERE state = 'active'
  AND pid != pg_backend_pid()
  AND query !~~ 'START_REPLICATION%'
  ORDER B Y backend_start;
  ]],
      {}
    )
  ),

  s(
    { trig = "bt", name = "new table" },
    fmt(
      [[
CREATE TABLE {} (
  {}
);

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "bc", name = "new column" },
    fmt(
      [[
ADD COLUMN {},
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "bac", name = "alter column" },
    fmt(
      [[
ALTER COLUMN {},
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "bact", name = "alter column type" },
    fmt(
      [[
ALTER COLUMN {} SET TYPE {} USING {},
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "be", name = "new enum" },
    fmt(
      [[
CREATE TYPE {} AS ENUM
  ({});
{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "bsq", name = "new sequence" },
    fmt(
      [[
CREATE SEQUENCE {};
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "bdc", name = "drop column" },
    fmt(
      [[
DROP COLUMN {}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "bdt", name = "drop table" },
    fmt(
      [[
DROP TABLE {};
]],
      { i(0) }
    )
  ),

  s(
    { trig = "bat", name = "alter table" },
    fmt(
      [[
ALTER TABLE {}
  {}; 

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "btv", name = "varchar" },
    fmt(
      [[
VARCHAR({}){}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "btt", name = "text" },
    fmt(
      [[
TEXT({}){}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "bai", name = "serial" },
    fmt(
      [[
BIGSERIAL{}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "bti", name = "integer" },
    fmt(
      [[
INTEGER{}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "btf", name = "float" },
    fmt(
      [[
FLOAT{}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "btb", name = "boolean" },
    fmt(
      [[
BOOLEAN{}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "bcf", name = "foreign key" },
    fmt(
      [[
FOREIGN KEY ({}) REFERENCES {} ({}),
{}
]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "bcp", name = "primary key" },
    fmt(
      [[
CONSTRAINT {} PRIMARY KEY ({}),
{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "bcr", name = "required" },
    fmt(
      [[
NOT NULL{}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "bcu", name = "unique" },
    fmt(
      [[
UNIQUE{}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "bi", name = "insert" },
    fmt(
      [[
INSERT INTO {} ({}) VALUES ({});
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "bs", name = "select" },
    fmt(
      [[
SELECT {} FROM {};
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "bd", name = "delete" },
    fmt(
      [[
DELETE FROM {} WHERE {};
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "bu", name = "update" },
    fmt(
      [[
UPDATE {}
  SET {}
  WHERE {};
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "bw", name = "where" },
    fmt(
      [[
WHERE {}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "bg", name = "group by" },
    fmt(
      [[
GROUP BY {}
]],
      { i(0) }
    )
  ),
})

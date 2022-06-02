require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local t = ls.text_node
local s = ls.s
local rep = require("luasnip.extras").rep

local s = function(context, nodes, options)
  return function()
    return ls.s(context, nodes, options)
  end
end

local input_in_snake_case = function(input_position)
  return f(function(inputs)
    return string.lower(
      vim.fn.substitute(inputs[1][1], "[^a-zA-Z0-9]", "_", "g")
    )
  end, { input_position })
end

return {
  s(
    { trig = "bl", name = "bullet list" },
    fmt(
      [[
\begin{{itemize}}
  \item {}

  {}
\end{{itemize}}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "bn", name = "bullet node" },
    fmt(
      [[
\item {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "nl", name = "numbered list" },
    fmt(
      [[
\begin{{enumerate}}
\item {}

{}
\end{{enumerate}}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "nn", name = "numbered node" },
    fmt(
      [[
\item {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s({ trig = "em", name = "emphasize" }, fmt("\\emph{{{}}}{}", { i(1), i(0) })),
  s(
    { trig = "bo", name = "boldface" },
    fmt("\\textbf{{{}}}{}", { i(1), i(0) })
  ),

  s(
    { trig = "h1", name = "section" },
    fmt(
      [[
\section{{{}}}\label{{sec:{}}}

{}
]],
      { i(1), input_in_snake_case(1), i(0) }
    )
  ),

  s(
    { trig = "h2", name = "subsection" },
    fmt(
      [[
\subsection{{{}}}\label{{sec:{}}}

{}
]],
      { i(1), input_in_snake_case(1), i(0) }
    )
  ),

  s(
    { trig = "h3", name = "subsubsection" },
    fmt(
      [[
\subsubsection{{{}}}\label{{sec:{}}}

{}
]],
      { i(1), input_in_snake_case(1), i(0) }
    )
  ),

  s(
    { trig = "to", name = "open tag" },
    fmt(
      [[
\begin{{{}}}
{}
\end{{{}}}

{}
]],
      { i(1), i(2), rep(1), i(0) }
    )
  ),

  s(
    { trig = "t1", name = "1 col table" },
    fmt(
      [[
\begin{{table}}
\centering
\caption{{\label{{tab:{}}} {}}}
\vspace{{1em}}
\begin{{tabular}}{{ l }}
{} \\ \toprule
{} \\
{} \\ \bottomrule
\end{{tabular}}
\end{{table}}

{}
]],
      { input_in_snake_case(1), i(1), i(2), i(3), i(4), i(0) }
    )
  ),

  s(
    { trig = "qu", name = "quote" },
    fmt(
      [[
\begin{{quote}}
{}
\end{{quote}}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "bb", name = "print bibliography" },
    fmt(
      [[
\printbibliography{{}}
{}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "bm", name = "manual biography" },
    fmt(
      [[
\begin{{thebibliography}}{{{}}}
{}
\end{{thebibliography}}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "bi", name = "bibitem" },
    fmt(
      [[
\bibitem {}
  {}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s({ trig = "bc", name = "cite" }, fmt("\\cite{{{}}} {}", { i(1), i(0) })),

  s(
    { trig = "ci", name = "code inline" },
    fmt("mintinline{{{}}}{{{}}} {}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "cb", name = "code block" },
    fmt(
      [[
\begin{{figure}}
\centering
\begin{{minted}}{{{}}}
{}
\end{{minted}}
\caption{{\label{{fig:{}}} {}}}
\end{{figure}}

{}
]],
      { i(1), i(2), input_in_snake_case(3), i(3), i(0) }
    )
  ),

  s(
    { trig = "im", name = "image" },
    fmt(
      [[
\begin{{figure}}
  \centering
  \includegraphics[width=\textwidth]{{{}}}
  \caption{{\label{{fig:{}}} {}}}
\end{{figure}}

{}
  ]],
      { i(1), input_in_snake_case(2), i(2), i(0) }
    )
  ),

  s(
    { trig = "id", name = "import default" },
    fmt(
      [[
\usepackage{{{}}}
{}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "rf", name = "ref" },
    fmt(
      [[
~\ref{{{}}}{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "rr", name = "ref range" },
    fmt(
      [[
~\ref{{{}}}~--~\ref{{{}}}{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "lb", name = "label" },
    fmt(
      [[
\label{{{}:{}}} {}
]],
      { i(1, "sec"), i(2), i(0) }
    )
  ),

  s(
    { trig = "ei", name = "equation inline" },
    fmt(
      [[
${}$ {}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "eq", name = "single equation" },
    fmt(
      [[
\begin{{equation}}\label{{eq:{}}}
  {}
\end{{equation}}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "eb", name = "equation block" },
    fmt(
      [[
\begin{{align*}}\label{{eq:{}}}
  {}
  \addtocounter{{equation}}{{1}}\tag{{\theequation}}
\end{{align*}}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ec", name = "chemistry equation" },
    fmt(
      [[
\begin{{equation}}\label{{eq:{}}}
  \ch{{{} -> {}}}
\end{{equation}}

{}
]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "ecn", name = "chemistry node" },
    fmt(
      [[
  \ch{{{}}} {}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ed", name = "division operator" },
    fmt(
      [[
\frac{{{}}}{{{}}} {}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "eo", name = "oxidation operator" },
    fmt(
      [[
  \ox{{{},{}}} {}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "if", name = "import file" },
    fmt(
      [[
\input{{{}}}
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "co", name = "text color" },
    fmt(
      [[
\textcolor{{{}}}{{{}}}{}
]],
      { i(1), i(2), i(0) }
    )
  ),
}

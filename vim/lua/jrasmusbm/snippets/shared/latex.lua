require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node

local s = function(context, nodes, options)
  return function()
    return ls.s(context, nodes, options)
  end
end

return {
  s(
    { trig = "bl", name = "bullet list" },
    fmt(
      [[
\begin{itemize}
  \item {}

  {}
\end{itemize}

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
\begin{enumerate}
\item {}

{}
\end{enumerate}

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
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "h2", name = "subsection" },
    fmt(
      [[
\subsection{{{}}}\label{{sec:{}}}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "h3", name = "subsubsection" },
    fmt(
      [[
\subsubsection{{{}}}\label{{sec:{}}}

{}
]],
      { i(1), i(2), i(0) }
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
\vspace{1em}
\begin{{tabular}}{{ l }}
{} \\ \toprule
{} \\
{} \\ \bottomrule
\end{{tabular}}
\end{{table}}

{}
]],
      { i(1), i(2), i(3), i(4), i(5), i(0) }
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
\bibitem{}
  {}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s({ trig = "bc", name = "cite" }, fmt("\\cite{{{}}} {}", { i(1), i(0) })),

  s(
    { trig = "ci", name = "code inline" },
    fmt("mintinline{{{}}}{{{}}} {}", {})
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
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),
}

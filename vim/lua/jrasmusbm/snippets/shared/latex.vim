" Columns {{{
inoremap  <leader>c2 \begin{multicols}{2}
      \<++>
      \\columnbreak
      \<++>
      \\end{multicols}:call bushels#backward_marker(2)
" }}}

" Image {{{
inoremap  <leader>im \begin{figure}
      \\centering
      \\includegraphics[width=\textwidth]{<++>}
      \\caption{\label{fig:<++>} <++>}
      \\end{figure}
      \<++>:call bushels#backward_marker(4)
" }}}

" Import {{{
" Named {{{
inoremap  <leader>in \usepackage{<++>} <++>:call bushels#backward_marker(2)
" }}}
" }}}

" References {{{
" Single {{{
inoremap  <leader>rf ~\ref{<++>}<++>:call bushels#backward_marker(2)
"}}}
" Range {{{
inoremap  <leader>rr ~\ref{<++>}~--~\ref{<++>}<++>:call bushels#backward_marker(3)
"}}}
" }}}

" Label {{{
inoremap  <leader>lb \label{<++>:<++>} <++>:call bushels#backward_marker(3)
" }}}

" Equation {{{
" Inline {{{
inoremap  <leader>ei $<++>$ <++>:call bushels#backward_marker(2)
" }}}
" Single {{{
inoremap  <leader>eq \begin{equation}\label{eq:<++>}	<++>\end{equation}
      \<++>:call bushels#backward_marker(3)
" }}}
" Block {{{
inoremap  <leader>eb \begin{align*}\label{eq:<++>}	<++>
      \\addtocounter{equation}{1}\tag{\theequation}\end{align*}
      \<++>:call bushels#backward_marker(3)
" }}}
" Chemistry {{{
inoremap  <leader>ec \begin{equation}\label{eq:<++>}\ch{<++> -> <++>}
      \\end{equation}<++>:call bushels#backward_marker(4)
" }}}
" }}}

" Operator {{{
" Chemistry {{{
inoremap  <leader>oc \ch{<++>} <++>:call bushels#backward_marker(2)
" }}}
" Oxidation {{{
inoremap  <leader>ox \ox{<++>,<++>} <++>:call bushels#backward_marker(3)
" }}}
" Equal {{{
inoremap  <leader>oe <++> = <++>:call bushels#backward_marker(2)
" }}}
" Addition {{{
inoremap  <leader>om <++> + <++>:call bushels#backward_marker(2)
" }}}
" Subtraction {{{
inoremap  <leader>os <++> - <++>:call bushels#backward_marker(2)
" }}}
" Multiplication {{{
inoremap  <leader>om <++> * <++>:call bushels#backward_marker(2)
" }}}
" Division {{{
inoremap  <leader>od \frac{<++>}{<++>} <++>:call bushels#backward_marker(3)
" }}}
" }}}

" Import {{{
" File {{{
inoremap  <leader>if \input{<++>}
            \<++>:call bushels#backward_marker(2)
" }}}
" }}}

" Color {{{
inoremap  <leader>co \textcolor{<++>}{<++>}<++>:call bushels#backward_marker(3)
" }}}

" Latex {{{
" File {{{
inoremap  <leader>lf \documentclass{article}
      \\usepackage[utf8]{inputenc}
      \\title{<++>}
      \\date{\today}
      \\author{<++>~\thanks{<++>}}
      \\begin{document}
      \\maketitle{}
      \\newpage{}
      \<++>
      \\end{document}:call bushels#backward_marker(4)
" }}}
" Module {{{
inoremap  <leader>lm % !TEX root = %
      \:s/\v\w+\ze\./main
      \:s/\v\w+\ze\//../g
      \:s/\v\.\.\///
      \o%oS
" }}}
" }}}

" TODO {{{
inoremap  <leader>td \textcolor{purple}{TODO}: <++>:call bushels#backward_marker(1)
" }}}

" CV {{{
" Item {{{
inoremap  <leader>vi \cventry{<++> -- <++>}
      \  {<++>}
      \{<++>}
      \{<++>}
      \{}
      \{}:call bushels#backward_marker(5)
" }}}
" }}}

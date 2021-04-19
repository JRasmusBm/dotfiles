" Bullet {{{
" List {{{
inoremap <buffer> <leader>bl \begin{itemize}\item <++>\end{itemize}<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Bullet {{{
inoremap <buffer> <leader>bn o\item  
" }}}
" }}}

" Numbered {{{
" List {{{
inoremap <buffer> <leader>nl \begin{enumerate}\item <++>\end{enumerate}<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Node {{{
inoremap <buffer> <leader>nn o\item  
" }}}
" }}}
       
" Emphasize {{{
inoremap <buffer> <leader>em \emph{<++>}<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}

" Boldface {{{
inoremap <buffer> <leader>bo \textbf{<++>}<++>:call jrasmusbm#snippets#backward_marker(2) 
" }}}
      
" Header {{{
" " H1 {{{
inoremap <buffer> <leader>h1 I<++>OO\section{<++>}\label{sec:<++>}:call jrasmusbm#snippets#backward_marker(2)
" }}}
" " H2 {{{
inoremap <buffer> <leader>h2 I<++>OO\subsection{<++>}\label{sec:<++>}:call jrasmusbm#snippets#backward_marker(2)
" }}}
" " H3 {{{
inoremap <buffer> <leader>h3 I<++>OO\subsubsection{<++>}\label{sec:<++>}:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Label {{{
inoremap <buffer> <leader>hl yi{:call jrasmusbm#snippets#forward_marker(1)"gui{F\i:s/ /-/gekJx:call jrasmusbm#snippets#forward_marker(1)
" }}}
" }}}
     
" Tag {{{
" Open {{{
inoremap <buffer> <leader>to \begin{<++>}<++>\end{<++>}<++>:call jrasmusbm#snippets#backward_marker(4) 
" }}}
" Close {{{
inoremap <buffer> <leader>tc yi{:call jrasmusbm#snippets#forward_marker(2)":call jrasmusbm#snippets#backward_marker(1) 
" }}}
" }}}

" Table {{{
" 1 Column {{{
inoremap <buffer> <leader>t1 \begin{table}
      \\centering
      \\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{ l } 
      \<++> \\ \toprule
      \<++> \\
      \<++> \\ \bottomrule
      \\end{tabular}
      \\end{table}
      \<++>:call jrasmusbm#snippets#backward_marker(6)
" }}}
" 2 Columns {{{
inoremap <buffer> <leader>t2 \begin{table}
      \\centering
      \\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{ l  l } 
      \<++> & <++> \\ \toprule
      \<++> & <++> \\
      \<++> & <++> \\ \bottomrule
      \\end{tabular}
      \\end{table}
      \<++>:call jrasmusbm#snippets#backward_marker(9)
" }}}
" 3 Columns {{{
inoremap <buffer> <leader>t3 \begin{table}
      \\centering
      \\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{ l  l  l } 
      \<++> & <++> & <++> \\ \toprule
      \<++> & <++> & <++> \\
      \<++> & <++> & <++> \\ \bottomrule
      \\end{tabular}
      \\end{table}
      \<++>:call jrasmusbm#snippets#backward_marker(12)
" }}}
" 4 Columns {{{
inoremap <buffer> <leader>t4 \begin{table}
      \\centering
      \\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{ l  l  l  l } 
      \<++> & <++> & <++> & <++> \\ \toprule
      \<++> & <++> & <++> & <++> \\
      \<++> & <++> & <++> & <++> \\ \bottomrule
      \\end{tabular}
      \\end{table}
      \<++>:call jrasmusbm#snippets#backward_marker(15)
" }}}
" 5 Columns {{{
inoremap <buffer> <leader>t5 \begin{table}
      \\centering
      \\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{ l  l  l  l  l } 
      \<++> & <++> & <++> & <++> & <++> \\ \toprule
      \<++> & <++> & <++> & <++> & <++> \\
      \<++> & <++> & <++> & <++> & <++> \\ \bottomrule
      \\end{tabular}
      \\end{table}
      \<++>:call jrasmusbm#snippets#backward_marker(18)
" }}}
" " 6 Columns {{{
inoremap <buffer> <leader>t6 \begin{table}
      \\centering
      \\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{ l  l  l  l  l  l } 
      \<++> & <++> & <++> & <++> & <++> & <++> \\ \toprule
      \<++> & <++> & <++> & <++> & <++> & <++> \\
      \<++> & <++> & <++> & <++> & <++> & <++> \\ \bottomrule
      \\end{tabular}
      \\end{table}
      \<++>:call jrasmusbm#snippets#backward_marker(21)
" }}}
" }}}

" Quote {{{
inoremap <buffer> <leader>qu I<++>OO\end{quote}O\begin{quote} 
" }}}
   
" Bibliography {{{
" File {{{
inoremap <buffer> <leader>bb \printbibliography{}
" }}}
" Manual {{{
inoremap <buffer> <leader>bm I<++>OO\end{thebibliography}O\begin{thebibliography}{<++>}<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Item {{{
inoremap <buffer> <leader>bi O<++>OO\bibitem{<++>}<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Cite {{{
inoremap <buffer> <leader>bc ~\cite{<++>} <++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
    
" Code {{{
" Inline {{{
inoremap <buffer> <leader>ci \mintinline{<++>}{<++>} <++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Block {{{
inoremap <buffer> <leader>cb \begin{figure}
      \\centering
      \\begin{minted}{<++>}
      \<++>
      \\end{minted}
      \\caption{\label{fig:<++>} <++>}
      \\end{figure}
      \<++>:call jrasmusbm#snippets#backward_marker(5)
" }}}
" }}}
  
" Image {{{
inoremap <buffer> <leader>im \begin{figure}
      \\centering
      \\includegraphics[width=\textwidth]{<++>}
      \\caption{\label{fig:<++>} <++>}
      \\end{figure}
      \<++>:call jrasmusbm#snippets#backward_marker(4)
" }}}

" Import {{{
" Named {{{
inoremap <buffer> <leader>in \usepackage{<++>} <++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
 
" References {{{
" Single {{{
inoremap <buffer> <leader>rf ~\ref{<++>}<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Range {{{
inoremap <buffer> <leader>rr ~\ref{<++>}~--~\ref{<++>}<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" }}}

" Label {{{
inoremap <buffer> <leader>lb \label{<++>:<++>} <++>:call jrasmusbm#snippets#backward_marker(3)
" }}}

" Equation {{{
" Inline {{{
inoremap <buffer> <leader>ei $<++>$ <++>:call jrasmusbm#snippets#backward_marker(2) 
" }}}
" Single {{{
inoremap <buffer> <leader>eq \begin{equation}\label{eq:<++>}	<++>\end{equation}
      \<++>:call jrasmusbm#snippets#backward_marker(3) 
" }}}
" Block {{{
inoremap <buffer> <leader>eb \begin{align*}\label{eq:<++>}	<++>
      \\addtocounter{equation}{1}\tag{\theequation}\end{align*}
      \<++>:call jrasmusbm#snippets#backward_marker(3) 
" }}}
" Chemistry {{{
inoremap <buffer> <leader>ec \begin{equation}\label{eq:<++>}\ch{<++> -> <++>}
      \\end{equation}<++>:call jrasmusbm#snippets#backward_marker(4)
" }}}
" }}}

" Operator {{{
" Chemistry {{{
inoremap <buffer> <leader>oc \ch{<++>} <++>:call jrasmusbm#snippets#backward_marker(2) 
" }}}
" Oxidation {{{
inoremap <buffer> <leader>ox \ox{<++>,<++>} <++>:call jrasmusbm#snippets#backward_marker(3) 
" }}}
" Equal {{{
inoremap <buffer> <leader>oe <++> = <++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Addition {{{
inoremap <buffer> <leader>om <++> + <++>:call jrasmusbm#snippets#backward_marker(2) 
" }}}
" Subtraction {{{
inoremap <buffer> <leader>os <++> - <++>:call jrasmusbm#snippets#backward_marker(2) 
" }}}
" Multiplication {{{
inoremap <buffer> <leader>om <++> * <++>:call jrasmusbm#snippets#backward_marker(2) 
" }}}
" Division {{{
inoremap <buffer> <leader>od \frac{<++>}{<++>} <++>:call jrasmusbm#snippets#backward_marker(3) 
" }}}
" }}}

" Import {{{
" File {{{
inoremap <buffer> <leader>if \input{<++>}
            \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}

" Color {{{
inoremap <buffer> <leader>co \textcolor{<++>}{<++>}<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}

" Latex {{{
" File {{{
inoremap <buffer> <leader>lf \documentclass{article}
      \\usepackage[utf8]{inputenc}
      \\title{<++>}
      \\date{\today}
      \\author{<++>~\thanks{<++>}}
      \\begin{document}
      \\maketitle{}
      \\newpage{}
      \<++>
      \\end{document}:call jrasmusbm#snippets#backward_marker(4)
" }}}
" }}}

" TODO {{{
inoremap <buffer> <leader>td \textcolor{purple}{TODO}: <++>:call jrasmusbm#snippets#backward_marker(1)
" }}}


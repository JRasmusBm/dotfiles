" Bullet {{{
" List {{{
inoremap <buffer> <leader>bl \begin{itemize}\item <++>\end{itemize}<++>:call BackwardMarker(2)
" }}}
" Bullet {{{
inoremap <buffer> <leader>bn o\item  
" }}}
" }}}

" Numbered {{{
" List {{{
inoremap <buffer> <leader>nl \begin{enumerate}\item <++>\end{enumerate}<++>:call BackwardMarker(2)
" }}}
" Node {{{
inoremap <buffer> <leader>nn o\item  
" }}}
" }}}
       
" Emphasize {{{
inoremap <buffer> <leader>em \emph{<++>}<++>:call BackwardMarker(2)
" }}}

" Boldface {{{
inoremap <buffer> <leader>bo \textbf{<++>}<++>:call BackwardMarker(2) 
" }}}
      
" Header {{{
" " H1 {{{
inoremap <buffer> <leader>h1 I<++>OO\section{<++>}\label{sec:<++>}:call BackwardMarker(2)
" }}}
" " H2 {{{
inoremap <buffer> <leader>h2 I<++>OO\subsection{<++>}\label{sec:<++>}:call BackwardMarker(2)
" }}}
" " H3 {{{
inoremap <buffer> <leader>h3 I<++>OO\subsubsection{<++>}\label{sec:<++>}:call BackwardMarker(2)
" }}}
" Label {{{
inoremap <buffer> <leader>hl yi{:call ForwardMarker(1)"gui{F\i:s/ /-/gkJ:call ForwardMarker(1)
" }}}
" }}}
     
" Tag {{{
" Open {{{
inoremap <buffer> <leader>to \begin{<++>}<++>\end{<++>}<++>:call BackwardMarker(4) 
" }}}
" Close {{{
inoremap <buffer> <leader>tc yi{:call ForwardMarker(2)":call BackwardMarker(1) 
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
      \<++>:call BackwardMarker(6)
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
      \<++>:call BackwardMarker(9)
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
      \<++>:call BackwardMarker(12)
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
      \<++>:call BackwardMarker(15)
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
      \<++>:call BackwardMarker(18)
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
      \<++>:call BackwardMarker(21)
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
inoremap <buffer> <leader>bm I<++>OO\end{thebibliography}O\begin{thebibliography}{<++>}<++>:call BackwardMarker(2)
" }}}
" Item {{{
inoremap <buffer> <leader>bi O<++>OO\bibitem{<++>}<++>:call BackwardMarker(2)
" }}}
" Cite {{{
inoremap <buffer> <leader>bc ~\cite{<++>} <++>:call BackwardMarker(2)
" }}}
" }}}
    
" Code {{{
" Inline {{{
inoremap <buffer> <leader>ci \mintinline{<++>}{<++>} <++>:call BackwardMarker(3)
" }}}
" Block {{{
inoremap <buffer> <leader>cb \begin{figure}
      \\centering
      \\begin{minted}{<++>}
      \<++>
      \\end{minted}
      \\caption{\label{fig:<++>} <++>}
      \\end{figure}
      \<++>:call BackwardMarker(5)
" }}}
" }}}
  
" Image {{{
inoremap <buffer> <leader>im \begin{figure}
      \\centering
      \\includegraphics[width=\textwidth]{<++>}
      \\caption{\label{fig:<++>} <++>}
      \\end{figure}
      \<++>:call BackwardMarker(4)
" }}}

" Import {{{
" Named {{{
inoremap <buffer> <leader>in \usepackage{<++>} <++>:call BackwardMarker(2)
" }}}
" }}}
 
" References {{{
" Single {{{
inoremap <buffer> <leader>rf ~\ref{<++>}<++>:call BackwardMarker(2)
"}}}
" Range {{{
inoremap <buffer> <leader>rr ~\ref{<++>}~--~\ref{<++>}<++>:call BackwardMarker(3)
"}}}
" }}}

" Label {{{
inoremap <buffer> <leader>lb \label{<++>:<++>} <++>:call BackwardMarker(3)
" }}}

" Equation {{{
" Inline {{{
inoremap <buffer> <leader>ei $<++>$ <++>:call BackwardMarker(2) 
" }}}
" Single {{{
inoremap <buffer> <leader>eq \begin{equation}\label{eq:<++>}	<++>\end{equation}
      \<++>:call BackwardMarker(3) 
" }}}
" Block {{{
inoremap <buffer> <leader>eb \begin{align*}\label{eq:<++>}	<++>
      \\addtocounter{equation}{1}\tag{\theequation}\end{align*}
      \<++>:call BackwardMarker(3) 
" }}}
" Chemistry {{{
inoremap <buffer> <leader>ec \begin{equation}\label{eq:<++>}\ch{<++> -> <++>}
      \\end{equation}<++>:call BackwardMarker(4)
" }}}
" }}}

" Operator {{{
" Chemistry {{{
inoremap <buffer> <leader>oc \ch{<++>} <++>:call BackwardMarker(2) 
" }}}
" Oxidation {{{
inoremap <buffer> <leader>ox \ox{<++>,<++>} <++>:call BackwardMarker(3) 
" }}}
" Equal {{{
inoremap <buffer> <leader>oe <++> = <++>:call BackwardMarker(2)
" }}}
" Addition {{{
inoremap <buffer> <leader>om <++> + <++>:call BackwardMarker(2) 
" }}}
" Subtraction {{{
inoremap <buffer> <leader>os <++> - <++>:call BackwardMarker(2) 
" }}}
" Multiplication {{{
inoremap <buffer> <leader>om <++> * <++>:call BackwardMarker(2) 
" }}}
" Division {{{
inoremap <buffer> <leader>od \frac{<++>}{<++>} <++>:call BackwardMarker(3) 
" }}}
" }}}

" Import {{{
" File {{{
inoremap <buffer> <leader>if \input{<++>}
            \<++>:call BackwardMarker(2)
" }}}
" }}}

" Color {{{
inoremap <buffer> <leader>co \textcolor{<++>}{<++>}<++>:call BackwardMarker(3)
" }}}

" TODO {{{
inoremap <buffer> <leader>td \textcolor{purple}{TODO}: <++>:call BackwardMarker(1)
" }}}

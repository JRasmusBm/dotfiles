inoremap <buffer> <leader>bl \begin{itemize}\item <++>\end{itemize}<++>:call BackwardMarker(2)
inoremap <buffer> <leader>nl \begin{enumerate}\item <++>\end{enumerate}<++>:call BackwardMarker(2)
inoremap <buffer> <leader>nn o\item  
inoremap <buffer> <leader>bn o\item  
       
inoremap <buffer> <leader>em \emph{<++>}<++>:call BackwardMarker(2)
inoremap <buffer> <leader>bo \textbf{<++>}<++>:call BackwardMarker(2) 
      
inoremap <buffer> <leader>h1 I<++>OO\section{<++>}\label{sec:<++>}:call BackwardMarker(2)
inoremap <buffer> <leader>h2 I<++>OO\subsection{<++>}\label{sec:<++>}:call BackwardMarker(2)
inoremap <buffer> <leader>h3 I<++>OO\subsubsection{<++>}\label{sec:<++>}:call BackwardMarker(2)
" Header {{{
" Label {{{
inoremap <buffer> <leader>hl yi{:call ForwardMarker(1)"gui{F\i:s/ /-/gkJ:call ForwardMarker(1)
" }}}
" }}}
     
inoremap <buffer> <leader>to \begin{<++>}<++>\end{<++>}<++>:call BackwardMarker(4) 
inoremap <buffer> <leader>tc yi{:call ForwardMarker(2)":call BackwardMarker(1) 

inoremap <buffer> <leader>t1 \begin{table}\centering\caption{\label{tab:<++>} <++>}
      \\vspace{1em}\begin{tabular}{\| c \|} 
      \<++>\end{tabular}\end{table}
      \<++>:call BackwardMarker(4)
inoremap <buffer> <leader>t2 \begin{table}\centering\caption{\label{tab:<++>} <++>}
      \\vspace{1em}\begin{tabular}{\| c \| c \|} 
      \<++> & <++>\end{tabular}
      \\end{table}
      \<++>:call BackwardMarker(5)
inoremap <buffer> <leader>t3 \begin{table}\centering\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{\| c \| c \| c \|} 
      \<++> & <++> & <++>\end{tabular}
      \\end{table}
      \<++>:call BackwardMarker(6)
inoremap <buffer> <leader>t4 \begin{table}\centering\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{\| c \| c \| c \| c \|} 
      \<++> & <++> & <++> & <++>\end{tabular}
      \\end{table}
      \<++>:call BackwardMarker(7)
inoremap <buffer> <leader>t5 \begin{table}\centering\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{\| c \| c \| c \| c \| c \|} 
      \<++> & <++> & <++> & <++> & <++>\end{tabular}
      \\end{table}
      \<++>:call BackwardMarker(8)
inoremap <buffer> <leader>t6 \begin{table}\centering\caption{\label{tab:<++>} <++>}
      \\vspace{1em}
      \\begin{tabular}{\| c \| c \| c \| c \| c \| c \|} 
      \<++> & <++> & <++> & <++> & <++> & <++>\end{tabular}
      \\end{table}
      \<++>:call BackwardMarker(9)
inoremap <buffer> <leader>qu I<++>OO\end{quote}O\begin{quote} 
   
inoremap <buffer> <leader>sl I<++>OO\end{thebibliography}O\begin{thebibliography}{<++>}<++>:call BackwardMarker(2)
inoremap <buffer> <leader>si O<++>OO\bibitem{<++>}<++>:call BackwardMarker(2)
inoremap <buffer> <leader>so ~\cite{<++>} <++>:call BackwardMarker(2)
    
inoremap <buffer> <leader>ci \mintinline{<++>}{<++>} <++>:call BackwardMarker(3)
inoremap <buffer> <leader>cb \begin{figure}[H]\centering\begin{minted}{<++>}<++>\end{minted}\caption{\label{fig:<++>} <++>}\end{figure}<++>:call BackwardMarker(5)
  
inoremap <buffer> <leader>im \begin{figure}[H]\centering\includegraphics[width=\textwidth]{<++>}\caption{\label{fig:<++>} <++>}\end{figure}<++>:call BackwardMarker(4)
inoremap <buffer> <leader>in \usepackage{<++>} <++>:call BackwardMarker(2)
 
inoremap <buffer> <leader>rf ~\ref{<++>} <++>:call BackwardMarker(2)
inoremap <buffer> <leader>lb \label{<++>:<++>} <++>:call BackwardMarker(3)

inoremap <buffer> <leader>ei $<++>$ <++>:call BackwardMarker(2) 
inoremap <buffer> <leader>eq \begin{equation}\label{eq:<++>}	<++>\end{equation}
      \<++>:call BackwardMarker(3) 
inoremap <buffer> <leader>eb \begin{align*}\label{eq:<++>}	<++>
      \\addtocounter{equation}{1}\tag{\theequation}\end{align*}
      \<++>:call BackwardMarker(3) 
inoremap <buffer> <leader>ce \begin{equation}\label{eq:<++>}\ch{<++> -> <++>}
      \\end{equation}<++>:call BackwardMarker(4)
inoremap <buffer> <leader>ch \ch{<++>} <++>:call BackwardMarker(2) 
inoremap <buffer> <leader>ox \ox{<++>,<++>} <++>:call BackwardMarker(3) 
inoremap <buffer> <leader>me <++> = <++>:call BackwardMarker(2)
inoremap <buffer> <leader>ao <++> + <++>:call BackwardMarker(2) 
inoremap <buffer> <leader>su <++> - <++>:call BackwardMarker(2) 
inoremap <buffer> <leader>mo <++> * <++>:call BackwardMarker(2) 
inoremap <buffer> <leader>do \frac{<++>}{<++>} <++>:call BackwardMarker(3) 
" Import {{{
" File {{{
inoremap <buffer> <leader>if \input{<++>}
            \<++>:call BackwardMarker(2)
" }}}
" }}}

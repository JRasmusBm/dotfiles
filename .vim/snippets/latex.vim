inoremap <buffer> ;bl \begin{itemize}\item <++>\end{itemize}<++>:call BackwardMarker(2)
inoremap <buffer> ;nl \begin{enumerate}\item <++>\end{enumerate}<++>:call BackwardMarker(2)
inoremap <buffer> ;nn o\item  
inoremap <buffer> ;bn o\item  
       
inoremap <buffer> ;em \emph{<++>} <++>:call BackwardMarker(2)
inoremap <buffer> ;bf \textbf{<++>} <++>:call BackwardMarker(2) 
      
inoremap <buffer> ;h1 I<++>OO\section{<++>}\label{sec:<++>}:call BackwardMarker(2)
inoremap <buffer> ;h2 I<++>OO\subsection{<++>}\label{sec:<++>}:call BackwardMarker(2)
inoremap <buffer> ;h3 I<++>OO\subsubsection{<++>}\label{sec:<++>}:call BackwardMarker(2)
     

inoremap <buffer> ;t1 \begin{table}\centering\begin{tabular}{\| c \|} 
      \<++>\end{tabular}\caption{\label{tab:<++>} <++>}\end{table}
      \<++>:call BackwardMarker(4)
inoremap <buffer> ;t2 \begin{table}\centering\begin{tabular}{\| c \| c \|} 
      \<++> & <++>\end{tabular}
      \\caption{\label{tab:<++>} <++>}\end{table}
      \<++>:call BackwardMarker(5)
inoremap <buffer> ;t3 \begin{table}\centering
      \\begin{tabular}{\| c \| c \| c \|} 
      \<++> & <++> & <++>\end{tabular}
      \\caption{\label{tab:<++>} <++>}\end{table}
      \<++>:call BackwardMarker(6)
inoremap <buffer> ;t4 \begin{table}\centering
      \\begin{tabular}{\| c \| c \| c \| c \|} 
      \<++> & <++> & <++> & <++>\end{tabular}
      \\caption{\label{tab:<++>} <++>}\end{table}
      \<++>:call BackwardMarker(7)
inoremap <buffer> ;t5 \begin{table}\centering
      \\begin{tabular}{\| c \| c \| c \| c \| c \|} 
      \<++> & <++> & <++> & <++> & <++>\end{tabular}
      \\caption{\label{tab:<++>} <++>}\end{table}
      \<++>:call BackwardMarker(8)
inoremap <buffer> ;t6 \begin{table}\centering
      \\begin{tabular}{\| c \| c \| c \| c \| c \| c \|} 
      \<++> & <++> & <++> & <++> & <++> & <++>\end{tabular}
      \\caption{\label{tab:<++>} <++>}\end{table}
      \<++>:call BackwardMarker(9)
inoremap <buffer> ;qu I<++>OO\end{quote}O\begin{quote} 
   
inoremap <buffer> ;sl I<++>OO\end{thebibliography}O\begin{thebibliography}{<++>}<++>:call BackwardMarker(2)
inoremap <buffer> ;si O<++>OO\bibitem{<++>}<++>:call BackwardMarker(2)
inoremap <buffer> ;so ~\cite{<++>} <++>:call BackwardMarker(2)
    
inoremap <buffer> ;ci \mintinline{<++>}{<++>} <++>:call BackwardMarker(3)
inoremap <buffer> ;cb \begin{figure}[H]\centering\begin{minted}{<++>}<++>\end{minted}\caption{\label{fig:<++>} <++>}\end{figure}<++>:call BackwardMarker(5)
  
inoremap <buffer> ;im \begin{figure}[H]\centering\includegraphics[width=\textwidth]{<++>}\caption{\label{fig:<++>} <++>}\end{figure}<++>:call BackwardMarker(4)
inoremap <buffer> ;in \usepackage{<++>} <++>:call BackwardMarker(2)
 
inoremap <buffer> ;rf ~\ref{<++>} <++>:call BackwardMarker(2)
inoremap <buffer> ;lb \label{<++>:<++>} <++>:call BackwardMarker(3)

inoremap <buffer> ;ei $<++>$ <++>:call BackwardMarker(2) 
inoremap <buffer> ;eq \begin{equation}\label{eq:<++>}	<++>\end{equation}
      \<++>:call BackwardMarker(3) 
inoremap <buffer> ;eb \begin{align*}\label{eq:<++>}	<++>
      \\addtocounter{equation}{1}\tag{\theequation}\end{align*}
      \<++>:call BackwardMarker(3) 
inoremap <buffer> ;ce \begin{equation}\label{eq:<++>}\ch{<++> -> <++>}
      \\end{equation}<++>:call BackwardMarker(4)
inoremap <buffer> ;ch \ch{<++>} <++>:call BackwardMarker(2) 
inoremap <buffer> ;ox \ox{<++>,<++>} <++>:call BackwardMarker(3) 
inoremap <buffer> ;me <++> = <++>:call BackwardMarker(2)
inoremap <buffer> ;ao <++> + <++>:call BackwardMarker(2) 
inoremap <buffer> ;su <++> - <++>:call BackwardMarker(2) 
inoremap <buffer> ;mo <++> * <++>:call BackwardMarker(2) 
inoremap <buffer> ;do \frac{<++>}{<++>} <++>:call BackwardMarker(3) 

inoremap <buffer> ;bl \begin{itemize}\item <++>\end{itemize}<++>:call BackwardMarker(2)
inoremap <buffer> ;nl \begin{enumerate}\item <++>\end{enumerate}<++>:call BackwardMarker(2)
inoremap <buffer> ;nn o\item  
inoremap <buffer> ;bn o\item  
       
inoremap <buffer> ;em \emph{<++>} <++>:call BackwardMarker(2)
      
inoremap <buffer> ;h1 I<++>OO\section{<++>}\label{sec:<++>}:call BackwardMarker(2)
inoremap <buffer> ;h2 I<++>OO\subsection{<++>}\label{sec:<++>}:call BackwardMarker(2)
inoremap <buffer> ;h3 I<++>OO\subsubsection{<++>}\label{sec:<++>}:call BackwardMarker(2)
     
inoremap <buffer> ;qu I<++>OO\end{quote}O\begin{quote} 
   
inoremap <buffer> ;sl I<++>OO\end{thebibliography}O\begin{thebibliography}{<++>}<++>:call BackwardMarker(2)
inoremap <buffer> ;si O<++>OO\bibitem{<++>}<++>:call BackwardMarker(2)
inoremap <buffer> ;so ~\cite{<++>} <++>:call BackwardMarker(2)
    
inoremap <buffer> ;ci \mintinline{<++>}{<++>} <++>:call BackwardMarker(3)
inoremap <buffer> ;cb \begin{figure}[H]\centering\begin{minted}{<++>}<++>\end{minted}\caption{\label{fig:<++>} <++>}\end{figure}<++>:call BackwardMarker(5)
  
inoremap <buffer> ;im \begin{figure}[H]\centering\includegraphics[width=\textwidth]{<++>}\caption{\label{fig:<++>} <++>}\end{figure}<++>:call BackwardMarker(4)
inoremap <buffer> ;pk \usepackage{<++>} <++>:call BackwardMarker(2)
 
inoremap <buffer> ;rf ~\ref{<++>} <++>:call BackwardMarker(2)
inoremap <buffer> ;lb \label{<++>:<++>} <++>:call BackwardMarker(3)

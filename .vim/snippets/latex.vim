inoremap ;bl \begin{itemize}\item <++>\end{itemize}<++>:call BackwardMarker(2)
inoremap ;nl \begin{enumerate}\item <++>\end{enumerate}<++>:call BackwardMarker(2)
inoremap ;nn o\item  
inoremap ;bn o\item  

inoremap ;em \emph{<++>} <++>:call BackwardMarker(2)

inoremap ;h1 I<++>OO\section{<++>}\label{sec:<++>}:call BackwardMarker(2)
inoremap ;h2 I<++>OO\subsection{<++>}\label{sec:<++>}:call BackwardMarker(2)
inoremap ;h3 I<++>OO\subsubsection{<++>}\label{sec:<++>}:call BackwardMarker(2)

inoremap ;qu I<++>OO\end{quote}O\begin{quote} 

inoremap ;sl I<++>OO\end{thebibliography}O\begin{thebibliography}{<++>}<++>:call BackwardMarker(2)
inoremap ;si O<++>OO\bibitem{<++>}<++>:call BackwardMarker(2)
inoremap ;so ~\cite{<++>} <++>:call BackwardMarker(2)

inoremap ;ci \mintinline{<++>}{<++>} <++>:call BackwardMarker(3)
inoremap ;cb \begin{figure}\centering\begin{minted}{<++>}<++>\end{minted}\caption{\label{fig:<++>} <++>}\end{figure}<++>:call BackwardMarker(5)

inoremap ;im \begin{figure}\centering\includegraphics{<++>}\caption{\label{fig:<++>} <++>}\end{figure}<++>:call BackwardMarker(4)
inoremap ;pk \usepackage{<++>} <++>:call BackwardMarker(2)

inoremap ;rf ~\ref{<++>} <++>:call BackwardMarker(2)
inoremap ;lb \label{<++>:<++>} <++>:call BackwardMarker(3)

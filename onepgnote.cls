%---------------------------------- Roll back part -----------------------------
\DeclareCurrentRelease{v0.9.0}{2025-04-26}

%---------------------------------- ID part -----------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{onepgnote}[v0.9 All functions work but mostly not configurable.
On that I will work later.]

%---------------------------------- Declare options -----------------------------
% For now, I have not options. Just pass all of them to article.
\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{article}
}

%---------------------------------- Execute options -----------------------------
\ProcessOptions \relax

%---------------------------------- Package loading -----------------------------
% Based on article
\LoadClass{article}

% Drawing, etc.
\RequirePackage{tikz}
% Heavily relies on these boxes.
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}

%---------------------------------- Main code -----------------------------
% Features:
% 1. Make sections occupy as little space as possible, while still maintaining
% their noticibility.
%
% 2. Heavy use of inline enumeration.
%
% 3. Since hyper references will have no effect in print, make all labels and
% references visible and give each a unique mark in letter (to save space: to
% write 11 one needs two characters in number but can be done by using K).
%
% 4. Keep displayed math but make their above and below skip much less.
%
% 5. Use conspicuous tcolorbox to mark important things.

%%%%%%%%%%%%%%%%%% Feature 1 %%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\section}[1]{%
	\vspace{5pt plus 2pt minus 3pt}%
	\par\noindent%start a new paragraph
	\tcbox[%
		nobeforeafter,box align=base,% inline box
		blanker,
		left=3mm,right=1mm,
		bottom=1mm,
		borderline east={2pt}{0pt}{red},
		borderline south={2pt}{0pt}{red}
	]{%
		\bfseries\large #1%
	}
}
\renewcommand{\subsection}[1]{%
	\par\noindent% start a new paragraph, but do not add additional vspace.
	\fbox{\bfseries #1}%
}
\renewcommand{\subsubsection}[1]{%
	\textbf{#1}%
}


%%%%%%%%%%%%%%%%%% Feature 2 %%%%%%%%%%%%%%%%%%%%%%%
% small colored counter for inline enumeration
\newcounter{coloredboxcounter}
\setcounter{coloredboxcounter}{0}
% display the counter in a small colored box
\newcommand{\coloredctr}{%
	\stepcounter{coloredboxcounter}% Increment the counter
	\tikz[baseline=(box.base)]{
		\node[rectangle, draw=black, fill=cyan!50, rounded corners=2pt,
		inner sep=2pt] (box)
		{\thecoloredboxcounter};%
	}%
}
\renewenvironment{enumerate}{%
	\begingroup% use a group so that \item is only defined inside.
	\setcounter{coloredboxcounter}{0}% reset the counter
	\def\item{\coloredctr\ }% with a space at the end.
}{%
	\endgroup
}

%%%%%%%%%%%%%%%%%% Feature 3 %%%%%%%%%%%%%%%%%%%%%%%
% Visible colored box for labels and references.
\newtcbox{\mylblbox}{%
	nobeforeafter,box align=base,
	colback=green!40!white, sharp corners,
	size=tight%
}

% counter for labels
\newcounter{coloredlblctr}
\setcounter{coloredlblctr}{0}
\renewcommand{\label}[1]{%
	\stepcounter{coloredlblctr}%
	% Store the counter's value
	% \xdef stands for \global\edef, where \edef 
	% defines the control sequence to be the expansion of the definition,
	% not just a copy of the definition's text.
	\expandafter\xdef\csname mylabel#1\endcsname{%
	\thecoloredlblctr}%
	% Create a visible lable block onsite.
	\mylblbox{L\thecoloredlblctr}%
}
\renewcommand{\ref}[1]{%
	% If mylabel#1 is undefined,
	% then the output will be empty.
	\mylblbox{R\csname mylabel#1\endcsname}%
}

%%%%%%%%%%%%%%%%%% Feature 4 %%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{%
\abovedisplayskip=1pt plus 2pt minus 1pt
\abovedisplayshortskip=1pt plus 2pt minus 1pt
\belowdisplayskip=1pt plus 2pt minus 1pt
\belowdisplayshortskip=1pt plus 2pt minus 1pt
}

%%%%%%%%%%%%%%%%%% Feature 5 %%%%%%%%%%%%%%%%%%%%%%%
\newtcbox{\notebox}{%
	colback=yellow, colframe=yellow, sharp corners,
	nobeforeafter,box align=base,% inline box
	size=tight
}
\newcommand\mynote{\notebox{NOTE}\ }

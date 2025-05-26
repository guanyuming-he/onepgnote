%---------------------------------- Roll back part -----------------------------
\DeclareCurrentRelease{v1.0.0}{2025-05-26}

%---------------------------------- ID part -----------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{onepgnote}[v1.0 All main functions are now configurable.]

%---------------------------------- Declare options -----------------------------
\DeclareKeys[onepgnote]{
    % Section styling options
    sectionvspace.store = \onepgnote@sectionvspace,
    sectionleftmargin.store = \onepgnote@sectionleftmargin,
    sectionrightmargin.store = \onepgnote@sectionrightmargin,
    sectionbottommargin.store = \onepgnote@sectionbottommargin,
    sectionborderwidth.store = \onepgnote@sectionborderwidth,
    sectionbordercolor.store = \onepgnote@sectionbordercolor,
    
    % Enumeration options
    enumboxcolor.store = \onepgnote@enumboxcolor,
    enumboxrounding.store = \onepgnote@enumboxrounding,
    enumboxpadding.store = \onepgnote@enumboxpadding,
    
    % Label/reference box options
    labelboxcolor.store = \onepgnote@labelboxcolor,
    
    % Display math spacing options
    displayskipabove.store = \onepgnote@displayskipabove,
    displayskipaboveshort.store = \onepgnote@displayskipaboveshort,
    displayskipbelow.store = \onepgnote@displayskipbelow,
    displayskipbelowshort.store = \onepgnote@displayskipbelowshort,
    
    % Note box options  
    noteboxcolor.store = \onepgnote@noteboxcolor,
    noteboxframecolor.store = \onepgnote@noteboxframecolor
}
% Unknown key handler - pass to article class
\DeclareUnknownKeyHandler{\PassOptionsToClass{\CurrentOption}{article}}

% Set default values
\def\onepgnote@sectionvspace{5pt plus 2pt minus 3pt}
\def\onepgnote@sectionleftmargin{3mm}
\def\onepgnote@sectionrightmargin{1mm}
\def\onepgnote@sectionbottommargin{1mm}
\def\onepgnote@sectionborderwidth{2pt}
\def\onepgnote@sectionbordercolor{red}
\def\onepgnote@enumboxcolor{cyan!50}
\def\onepgnote@enumboxrounding{2pt}
\def\onepgnote@enumboxpadding{2pt}
\def\onepgnote@labelboxcolor{green!40!white}
\def\onepgnote@displayskipabove{1pt plus 2pt minus 1pt}
\def\onepgnote@displayskipaboveshort{1pt plus 2pt minus 1pt}
\def\onepgnote@displayskipbelow{1pt plus 2pt minus 1pt}
\def\onepgnote@displayskipbelowshort{1pt plus 2pt minus 1pt}
\def\onepgnote@noteboxcolor{yellow}
\def\onepgnote@noteboxframecolor{yellow}

%---------------------------------- Execute options -----------------------------
\ProcessKeyOptions[onepgnote]

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
		left=\onepgnote@sectionleftmargin,
		right=\onepgnote@sectionrightmargin,
		bottom=\onepgnote@sectionbottommargin,
		borderline east={\onepgnote@sectionborderwidth}{0pt}%
		{\onepgnote@sectionbordercolor},
		borderline south={\onepgnote@sectionborderwidth}{0pt}%
		{\onepgnote@sectionbordercolor}
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
		\node[rectangle, draw=black, 
		fill=\onepgnote@enumboxcolor,
		rounded corners=\onepgnote@enumboxrounding,
		inner sep=\onepgnote@enumboxpadding] (box)
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
	colback=\onepgnote@labelboxcolor, sharp corners,
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
\abovedisplayskip=\onepgnote@displayskipabove
\abovedisplayshortskip=\onepgnote@displayskipaboveshort
\belowdisplayskip=\onepgnote@displayskipbelow
\belowdisplayshortskip=\onepgnote@displayskipbelowshort
}

%%%%%%%%%%%%%%%%%% Feature 5 %%%%%%%%%%%%%%%%%%%%%%%
\newtcbox{\notebox}{%
	colback=\onepgnote@noteboxcolor, 
	colframe=\onepgnote@noteboxframecolor,
	sharp corners,
	nobeforeafter,box align=base,% inline box
	size=tight
}
\newcommand\mynote{\notebox{NOTE}\ }

\endinput

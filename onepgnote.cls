%---------------------------------- Roll back part -----------------------------
\DeclareCurrentRelease{v1.0.0}{2025-05-27}

%---------------------------------- ID part -----------------------------
\ProvidesClass{onepgnote}[v1.0 All main functions are now configurable.]

\RequirePackage{expl3}
\ExplSyntaxOn

%---------------------------------- Set default values ---------------------------
\tl_new:N \g__onepgnote_sectionvspace_tl
\tl_new:N \g__onepgnote_sectionleftmargin_tl
\tl_new:N \g__onepgnote_sectionrightmargin_tl
\tl_new:N \g__onepgnote_sectionbottommargin_tl
\tl_new:N \g__onepgnote_sectionborderwidth_tl
\tl_new:N \g__onepgnote_sectionbordercolor_tl
\tl_new:N \g__onepgnote_enumboxcolor_tl
\tl_new:N \g__onepgnote_enumboxrounding_tl
\tl_new:N \g__onepgnote_enumboxpadding_tl
\tl_new:N \g__onepgnote_labelboxcolor_tl
\tl_new:N \g__onepgnote_displayskipabove_tl
\tl_new:N \g__onepgnote_displayskipaboveshort_tl
\tl_new:N \g__onepgnote_displayskipbelow_tl
\tl_new:N \g__onepgnote_displayskipbelowshort_tl
\tl_new:N \g__onepgnote_noteboxcolor_tl
\tl_new:N \g__onepgnote_noteboxframecolor_tl

\tl_gset:Nn \g__onepgnote_sectionvspace_tl {5pt~plus~2pt~minus~3pt}
\tl_gset:Nn \g__onepgnote_sectionleftmargin_tl {3mm}
\tl_gset:Nn \g__onepgnote_sectionrightmargin_tl {1mm}
\tl_gset:Nn \g__onepgnote_sectionbottommargin_tl {1mm}
\tl_gset:Nn \g__onepgnote_sectionborderwidth_tl {2pt}
\tl_gset:Nn \g__onepgnote_sectionbordercolor_tl {red}
\tl_gset:Nn \g__onepgnote_enumboxcolor_tl {cyan!50}
\tl_gset:Nn \g__onepgnote_enumboxrounding_tl {2pt}
\tl_gset:Nn \g__onepgnote_enumboxpadding_tl {2pt}
\tl_gset:Nn \g__onepgnote_labelboxcolor_tl {green!40!white}
\tl_gset:Nn \g__onepgnote_displayskipabove_tl {1pt~plus~2pt~minus~1pt}
\tl_gset:Nn \g__onepgnote_displayskipaboveshort_tl {1pt~plus~2pt~minus~1pt}
\tl_gset:Nn \g__onepgnote_displayskipbelow_tl {1pt~plus~2pt~minus~1pt}
\tl_gset:Nn \g__onepgnote_displayskipbelowshort_tl {1pt~plus~2pt~minus~1pt}
\tl_gset:Nn \g__onepgnote_noteboxcolor_tl {yellow}
\tl_gset:Nn \g__onepgnote_noteboxframecolor_tl {yellow}

%---------------------------------- Declare keys --------------------------------
\DeclareKeys
{
    sectionvspace .tl_gset:N = \g__onepgnote_sectionvspace_tl,
    sectionleftmargin .tl_gset:N = \g__onepgnote_sectionleftmargin_tl,
    sectionrightmargin .tl_gset:N = \g__onepgnote_sectionrightmargin_tl,
    sectionbottommargin .tl_gset:N = \g__onepgnote_sectionbottommargin_tl,
    sectionborderwidth .tl_gset:N = \g__onepgnote_sectionborderwidth_tl,
    sectionbordercolor .tl_gset:N = \g__onepgnote_sectionbordercolor_tl,
    enumboxcolor .tl_gset:N = \g__onepgnote_enumboxcolor_tl,
    enumboxrounding .tl_gset:N = \g__onepgnote_enumboxrounding_tl,
    enumboxpadding .tl_gset:N = \g__onepgnote_enumboxpadding_tl,
    labelboxcolor .tl_gset:N = \g__onepgnote_labelboxcolor_tl,
    displayskipabove .tl_gset:N = \g__onepgnote_displayskipabove_tl,
    displayskipaboveshort .tl_gset:N = \g__onepgnote_displayskipaboveshort_tl,
    displayskipbelow .tl_gset:N = \g__onepgnote_displayskipbelow_tl,
    displayskipbelowshort .tl_gset:N = \g__onepgnote_displayskipbelowshort_tl,
    noteboxcolor .tl_gset:N = \g__onepgnote_noteboxcolor_tl,
    noteboxframecolor .tl_gset:N = \g__onepgnote_noteboxframecolor_tl,
    unknown .code:n = \PassOptionsToClass{#1}{article}
}

%---------------------------------- Process options -----------------------------
\ProcessKeyOptions

%---------------------------------- Create LaTeX2e interface -------------------
\cs_new:Npn \onepgnote@sectionvspace { \tl_use:N \g__onepgnote_sectionvspace_tl }
\cs_new:Npn \onepgnote@sectionleftmargin { \tl_use:N \g__onepgnote_sectionleftmargin_tl }
\cs_new:Npn \onepgnote@sectionrightmargin { \tl_use:N \g__onepgnote_sectionrightmargin_tl }
\cs_new:Npn \onepgnote@sectionbottommargin { \tl_use:N \g__onepgnote_sectionbottommargin_tl }
\cs_new:Npn \onepgnote@sectionborderwidth { \tl_use:N \g__onepgnote_sectionborderwidth_tl }
\cs_new:Npn \onepgnote@sectionbordercolor { \tl_use:N \g__onepgnote_sectionbordercolor_tl }
\cs_new:Npn \onepgnote@enumboxcolor { \tl_use:N \g__onepgnote_enumboxcolor_tl }
\cs_new:Npn \onepgnote@enumboxrounding { \tl_use:N \g__onepgnote_enumboxrounding_tl }
\cs_new:Npn \onepgnote@enumboxpadding { \tl_use:N \g__onepgnote_enumboxpadding_tl }
\cs_new:Npn \onepgnote@labelboxcolor { \tl_use:N \g__onepgnote_labelboxcolor_tl }
\cs_new:Npn \onepgnote@displayskipabove { \tl_use:N \g__onepgnote_displayskipabove_tl }
\cs_new:Npn \onepgnote@displayskipaboveshort { \tl_use:N \g__onepgnote_displayskipaboveshort_tl }
\cs_new:Npn \onepgnote@displayskipbelow { \tl_use:N \g__onepgnote_displayskipbelow_tl }
\cs_new:Npn \onepgnote@displayskipbelowshort { \tl_use:N \g__onepgnote_displayskipbelowshort_tl }
\cs_new:Npn \onepgnote@noteboxcolor { \tl_use:N \g__onepgnote_noteboxcolor_tl }
\cs_new:Npn \onepgnote@noteboxframecolor { \tl_use:N \g__onepgnote_noteboxframecolor_tl }

\ExplSyntaxOff

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

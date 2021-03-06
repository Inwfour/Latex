%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Author: Warawoot Pacharoen
%% Date:   April 13, 2018
%% Email:  warawoot.p@ubu.ac.th, wpacharoen@gmail.com
%%
%% This class file is extended from chula.cls by Dr.Nattee Niparnan.
%%
%% You can freely modified this file.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Author: Supasate Choochaisri
%% Date:   April 19, 2012
%% Email:  supasate.c@gmail.com, supasate@larngeartech.com
%%
%% This class file is extended from chula.cls by Dr.Nattee Niparnan.
%% The chula.cls by Dr.Nattee is loosely based on the chula.sty package
%% originally written by Chatchawit Aporntewan. The chula.sty was
%% then undergone many minor changes by Nattee Niparnan, Teerayut
%% Hiruntaraporn, and Mahisorn Wongphati. Then, Nattee rewrote the
%% style file as a class file and provides several option making the
%% class to be more general. Finally, Supasate modified the class
%% file to be used with XeTeX and to comply with the regulation in
%% acedemic year 2554.
%%
%% You can freely modified this file.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Changelog
%% August 21, 2015: Dittaya Wanvarie
%%  - Move fontspec font settings to AtEndOfClass to avoid problem in Windows TeX
%% July 7, 2015: Dittaya Wanvarie
%%  - Delete unnecessary comments
%%  - Add more comments
%%  - Add standard fonts for English similar to IEEEtran template
%%  - Correct errors in English template
%%  - Re-define bibliography to use \normalfont
%%  - Add natbib required pacakge
%%  - Define \thalph order (ก, ข, ค, ง,...0) for appendices
%%  - Add setspace require package and force doublespacing
%% June 11, 2015: Dittaya Wanvarie
%%  - Move font settings to AtEndOfClass
%%  - Change Thai font scale to match roman uppercase character
%%  - Add 12pt option to base report class
%%  - Add \@ThaiBookTitle to all Co-advisor block
%%  - Change tabular settings in TH/EN sign pages
%%  - Add array package required for tabular
%%  - Fix bugs in co-advisor position in abstract pages
%% June 9, 2015: Dittaya Wanvarie
%%  - Change the width sign/department dotted line in TH/EN abstract page to fit "Mathematics and Computer Science"
%% July 21, 2014: Boonyarit Intiyot
%%  - Add option [Latin,Thai] to ucharclasses
%%  - Add \defaultfontfeatures{Mapping=tex-text}
%%  - To avoid problem with Miktex for Windows:
%%		-Move \newfontfamily\thaifont[Scale=MatchLowercase,Mapping=tex-text]{TH Sarabun New:script=thai}  to the end of file
%%      -Move \setTransitionTo{Thai}{\fontspec[Scale=MatchLowercase,Mapping=tex-text]{TH Sarabun New}} to the end of file and change it to \setTransitionTo{Thai}{\thaifont}
%%      -Add \setTransitionFrom{Thai}{\normalfont} at the end of file
%%
%% July 6, 2014: Dittaya Wanvarie
%%  - Add \defaultfontfeatures{Mapping=tex-text}
%%  - Change co-advisor parameter in the English abstract page to uppercase "except
%%    "Ph.D"
%%  - Add subjID for course report in ugrad
%%  - Add ugrad option for senior project report
%%  - Add "appendicesname" and "appendicespage" in ThaiCaption
%% May 3, 2012 : Supasate Choochaisri
%%  - Add a parameter to handle the uppercase of advisor's title except "Ph.D."
%%  - Rename chula_nat.bst to chulanat.bst to make it more compatible to LaTeX
%%    compiler.
%%  - Add a "numappendices" parameter to handle choosing "Appendix" or "Appendices"
%%  - Fix indentation of the Thai abstract page.
%%  - Modify the bibtex style file (chulanat.bst) to handle Chula bibliography
%%    format.
%%
%% Apr 19, 2012 : Supasate Choochaisri
%%  - Use XeTeX to support UTF-8 and OpenType font.
%%  - Use ucharclasses package to automatically switch language without
%%    explicitly issuing switch command.
%%  - Capitalize Advisor name at the English abstract page.
%%  - Add option for Advisor/Co-Advisor name with abbreviated title to be used
%%    at the English abstract page.
%%  - Write Deparment, Field of Study, and Academic year on dotted underlines
%%    at the abstract page.
%%  - Add semi-colon after Academic year at the English abstract page.
%%  - Move the word "Fulfillment" to the second line at the Approval page.
%%  - Adjust top margin to 1.5", bottom margin to 1.0" with geometry package.
%%  - Add line break for a long thesis title at the cover page.
%%
%% Feb 25, 2007: Nattee Niparnan
%%  - Change heading mechanism.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Identification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ubu}[2018/04/13]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Initial Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{calc}
\RequirePackage{fontspec}
\RequirePackage{xunicode}
\RequirePackage{xltxtra}
\RequirePackage{polyglossia}
\RequirePackage{ragged2e}
\RequirePackage{tikz}
\RequirePackage{geometry}
\RequirePackage{afterpage}
\RequirePackage{array}
\RequirePackage[Latin,Thai]{ucharclasses}

\RequirePackage{url}                       % for breaking urls (use \url{http://www.example.com})
\RequirePackage{breakcites}                % for breaking long citations
\RequirePackage[normalem]{ulem}            % for underlineing Journal name in references
\RequirePackage{setspace}                  % for double spacing

\setdefaultlanguage{english}
\setotherlanguage{thai}

\setTransitionTo{Thai}{\thaifont\doublespacing}
\setTransitionFrom{Thai}{\normalfont\doublespacing}

\XeTeXlinebreaklocale "th_TH"
\XeTeXlinebreakskip = 0pt plus 1pt

\newif\if@doctor
\newif\if@master
\newif\if@ugrad
\newif\if@coadvisor
\newif\if@thaithesis
\@coadvisorfalse

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Option Declaration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\@ugradtrue
\DeclareOption{doctor} {
  \@doctortrue
  \@masterfalse
  \@ugradfalse
} \DeclareOption{master} {
  \@doctorfalse
  \@mastertrue
  \@ugradfalse
} \DeclareOption{ugrad} {
  \@doctorfalse
  \@masterfalse
} \DeclareOption{coadvisor} {
  \@coadvisortrue
} \DeclareOption{thaithesis} {
  \@thaithesistrue
} \DeclareOption{engthesis} {
  \@thaithesisfalse
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}  % pass any unknown option to the report class

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Option Execution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExecuteOptions{ugrad,thaithesis}
\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Class & Package Loading %%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[a4paper,12pt]{report}           % this class is based on the report class

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Main Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtEndOfClass{
% Add natbib after set all other parameters
%\RequirePackage[round,semicolon]{natbib}                    % for bibliography sylte
\RequirePackage[square,comma,numbers]{natbib}

\renewenvironment{thebibliography}[1]{%
  \thereferences
  \bibsection\parindent \z@\bibpreamble\bibfont\list
   {\@biblabel{\arabic{NAT@ctr}}}{\@bibsetup{#1}%
    \setcounter{NAT@ctr}{0}}%

    \normalfont

    \ifNAT@openbib
      \renewcommand\newblock{\par}
    \else
      \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
    \fi
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=1000\relax
    \let\citeN\cite \let\shortcite\cite
    \let\citeasnoun\cite
 }{\def\@noitemerr{%
  \PackageWarning{natbib}
     {Empty `thebibliography' environment}}%
  \endlist\vskip-\lastskip
}

%% English fonts are Times, Helvetica, Courier, according to IEEEtran template
\defaultfontfeatures{Mapping=tex-text}
\setmainfont{TeX Gyre Termes}				% Free Times
\setsansfont{TeX Gyre Heros}				% Free Helvetica
\setmonofont{TeX Gyre Cursor}				% Free Courier

% Use TH Sarabun New for Thai as it is standard font for Thai formal documents
\newfontfamily{\thaifont}[Scale=MatchUppercase,Mapping=tex-text]{TH Sarabun New:script=thai}

\doublespacing
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% define Thai alphabet sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\thalph#1{\expandafter\@thalph\csname c@#1\endcsname}
\def\@thalph#1{%
  \ifcase#1\or ก\or ข\or ค\or ง\or จ\or ฉ\or ช\or ซ\or
   ฌ\or ญ\or ฎ\or ฏ\or ฐ\or ฑ\or ฒ\or ณ\or ด\or ต\or ถ\or ท\or ธ\or น\or
    บ\or ป\or ผ\or ฝ\or พ\or ฟ\or ภ\or ม\or ย\or ร\or ฤ\or ล\or ฦ\or ว\or
     ศ\or ษ\or ส\or ห\or ฬ\or อ\or ฮ\else\xpg@ill@value{#1}{@thaialph}\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% localize the strings (xxxxname )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\fillin[1][3cm]{\makebox[#1]{\dotfill}}

\newcommand\selectthesislang{
  \if@thaithesis
    \selectlanguage{thai}
  \else
    \selectlanguage{english}
  \fi
}

%% string setting
\if@doctor
  \newcommand\@ThaiDegreeType{ปริญญาดุษฎีบัณฑิต}
  \newcommand\@EnglishDegreeType{Doctoral Degree}
  \newcommand\@ThaiBookTitle{วิทยานิพนธ์}
  \newcommand\@EnglishBookTitle{Dissertation}
\else
  \if@master
    \newcommand\@ThaiDegreeType{ปริญญามหาบัณฑิต}
    \newcommand\@EnglishDegreeType{Master's Degree}
    \newcommand\@ThaiBookTitle{วิทยานิพนธ์}
    \newcommand\@EnglishBookTitle{Thesis}
  \else
    \newcommand\@ThaiDegreeType{ปริญญาบัณฑิต}
    \newcommand\@EnglishDegreeType{Bachelor's Degree}
    \newcommand\@ThaiBookTitle{โครงงาน}
    \newcommand\@EnglishBookTitle{Project}
  \fi
\fi

\if@thaithesis
  %% my new string
  \newcommand{\@AcknowledgementsString}{กิตติกรรมประกาศ}
  \if@ugrad
    \newcommand{\@BiographyString}{ประวัติผู้เขียน}
  \else
    \newcommand{\@BiographyString}{ประวัติผู้เขียนวิทยานิพนธ์}
  \fi
  \newcommand{\@AbstractThaiString}{บทคัดย่อภาษาไทย}
  \newcommand{\@AbstractEnglishString}{บทคัดย่อภาษาอังกฤษ}
  \newcommand{\@PageString}{หน้า}
  \newcommand{\@ThaiFont}{\normalfont}

  %%string already defined in babel (some are not used in this class, but I add it anyway
    \renewcommand\captionsthai{%
      \def\prefacename{คำนำ}%
      \def\refname{หนังสืออ้างอิง}%
      \def\abstractname{บทคัดย่อ}%
      \def\bibname{บรรณานุกรม}%
      \def\chaptername{บทที่}%
      \def\appendixname{ภาคผนวก}%
      \def\appendicesname{ภาคผนวก}%
      \def\appendixpage{ภาคผนวก}%
      \def\appendicespage{ภาคผนวก}%
      \def\contentsname{สารบัญ}%
      \def\listfigurename{สารบัญภาพ}%
      \def\listtablename{สารบัญตาราง}%
      \def\indexname{ดรรชนี}%
      \def\figurename{รูปที่}%
      \def\tablename{ตารางที่}%
      \def\partname{ภาค}%
      \def\enclname{สิ่งที่แนบมาด้วย}%
      \def\ccname{สำเนาถึง}%
      \def\headtoname{เรียน}%
      \def\pagename{หน้า}%
      \def\seename{ดู}%
      \def\alsoname{ดูเพิ่มเติม}%
      \def\proofname{พิสูจน์}%
    }
\else
  %% my new string
  \newcommand{\@AcknowledgementsString}{Acknowledgements}
  \newcommand{\@BiographyString}{Biography}
  \newcommand{\@AbstractThaiString}{Abstract (Thai)}
  \newcommand{\@AbstractEnglishString}{Abstract (English)}
  \newcommand{\@PageString}{Page}
  \newcommand{\@ThaiFont}{\normalfont}

  %%string already defined in babel (some are not used in this class, but I add it anyway
    \renewcommand\captionsenglish{%
      \def\prefacename{Preface}%
      \def\refname{References}%
      \def\abstractname{Abstract}%
      \def\bibname{References}%
      \def\chaptername{Chapter}%
      \def\appendixname{Appendix}%
      \def\appendicesname{Appendices}%
      \def\appendixpage{APPENDIX}%
      \def\appendicespage{APPENDICES}%
      \def\contentsname{Contents}%
      \def\listfigurename{List of Figures}%
      \def\listtablename{List of Tables}%
      \def\indexname{Index}%
      \def\figurename{Figure}%
      \def\tablename{Table}%
      \def\partname{Part}%
      \def\enclname{encl}%
      \def\ccname{cc}%
      \def\headtoname{To}%
      \def\pagename{Page}%
      \def\seename{see}%
      \def\alsoname{see also}%
      \def\proofname{Proof}%
      \def\glossaryname{Glossary}%
      \def\figurename{Figure}
      \def\tablename{Table}
    }
\fi

\if@thaithesis
  \captionsthai
\else
  \captionsenglish
\fi


%% set chapter string
\renewcommand\@chapapp{\chaptername}

%% to write text over dotted line
\newcommand{\udot}[1]{%
    \tikz[baseline=(todotted.south)]{
        \node[inner sep=0pt,outer sep=0pt] (todotted) {#1};
        \draw[loosely dotted, thick] (todotted.south west) -- (todotted.south east);
    }%
}%

%% to choose the word between Appendix or Appendices
\newcommand{\numappendices}[1]{
  \newcommand{\@numappendices}{#1}
}

%% additional command for setting the first few pages of the thesis
%% please refer to the accompanying bare_thesis.tex for the example
%% usage of these command.
\newcommand{\authortitle}[2]{                               % define Title of Author
  \newcommand{\@ThaiAuthorTitle}{#1}
  \newcommand{\@EnglishAuthorTitle}{#2}
}
\newcommand{\thesisauthor}[2]{                              % define author
  \newcommand{\@ThaiAuthor}{#1}
  \newcommand{\@EnglishAuthor}{#2}
  \newcommand{\@EnglishAuthorUP}{\uppercase{#2}}
}
\newcommand{\thesistitle}[2]{                               % define Thesis' title
  \newcommand{\@ThaiTitle}{#1}
  \newcommand{\@EnglishTitle}{#2}
}
\newcommand{\advisor}[4]{                                   % define Advisor
  \newcommand{\@ThaiAdvisor}{#1}
  \newcommand{\@ThaiAdvisorShort}{#2}
  \newcommand{\@EnglishAdvisor}{#3}
  \newcommand{\@EnglishAdvisorUP}{\uppercase{#3}}
  \newcommand{\@EnglishAdvisorShort}{#4}
  \newcommand{\@EnglishAdvisorShortUP}{\uppercase{#4}}
}
\newcommand{\coadvisor}[4]{                                 % define co-author (auto include coadvision option)
  \newcommand{\@ThaiCoAdvisor}{#1}
  \newcommand{\@ThaiCoAdvisorShort}{#2}
  \newcommand{\@EnglishCoAdvisor}{#3}
  \newcommand{\@EnglishCoAdvisorUP}{\uppercase{#3}}
  \newcommand{\@EnglishCoAdvisorShort}{#4}
  \newcommand{\@EnglishCoAdvisorShortUP}{\uppercase{#4}}
  \@coadvisortrue
}
\newcommand{\faculty}[2]{                                   % define faculty
  \newcommand{\@ThaiFaculty}{#1}
  \newcommand{\@EnglishFaculty}{#2}
}
\newcommand{\department}[2]{                                % define department
  \newcommand{\@ThaiDept}{#1}
  \newcommand{\@EnglishDept}{#2}
}
\newcommand{\fieldofstudy}[2]{                              % define field of study
  \newcommand{\@ThaiFieldOfStudy}{#1}
  \newcommand{\@EnglishFieldOfStudy}{#2}
  \newcommand{\@EnglishFieldOfStudyUP}{\uppercase{#2}}
}
\newcommand{\degree}[2]{                                    % define degree name
  \newcommand{\@ThaiDegree}{#1}
  \newcommand{\@EnglishDegree}{#2}
}
\newcommand{\academicyear}[1]{                              % define academic year
  \newcounter{AcadYear}
  \setcounter{AcadYear}{#1}
  \newcommand{\@ThaiAcademicYear}{\theAcadYear}
  \newcounter{EngAcadYear}
  \setcounter{EngAcadYear}{\value{AcadYear}-543}
  \newcommand{\@EnglishAcademicYear}{\theEngAcadYear}
}
\newcommand{\deanname}[2]{                                  % define name of the dean
  \newcommand{\@ThaiDeanName}{#1}
  \newcommand{\@EnglishDeanName}{#2}
}
\newcommand{\subjID}[1]{
  \newcommand{\@subjID}{#1}
}
\newcommand{\subjName}[2]{
  \newcommand{\@ThaiSubjName}{#1}
  \newcommand{\@EnglishSubjName}{#2}
}
\newcommand{\keywords}[1]{                                  % define keywords
  \newcommand{\@Keywords}{\uppercase{#1}}
}
\newcommand{\authorid}[1]{                                  % define student ID of the author
  \newcommand{\@AuthorID}{#1}
}
\newcommand{\committee}[1]{                                 % define commitee
  \newcommand{\@Committee}{
    \if@thaithesis \fi
    #1
  }
}

%% additional counter, length,  reference, etc

\newcounter{subsubsubsection}[subsubsection]
\setcounter{subsubsection}{0}                 % this class allow subsubsubsection

\newcounter{bib}                       \setcounter{bib}{0}
\newcounter{TotalPage}                 \setcounter{TotalPage}{0}
\newcounter{isAppendiced}              \setcounter{isAppendiced}{0}
                                       \setcounter{tocdepth}{5}
                                       \setcounter{secnumdepth}{5}

\newlength{\pageleft}               % for the remaining space of the page

\renewcommand{\thechapter}{\@ThaiFont\@arabic\c@chapter}                                    % \ref{} in chapter
\renewcommand{\thesection}{\@ThaiFont\thechapter.\@arabic\c@section}                        % \ref{} in section
\renewcommand{\thesubsection}{\@ThaiFont\thesection.\@arabic\c@subsection}                  % \ref{} in subsection
\renewcommand{\thesubsubsection}{\@ThaiFont\thesubsection.\@arabic\c@subsubsection}         % \ref{} in subsubsection
\renewcommand{\thesubsubsubsection}{\@ThaiFont\thesubsubsection.\@arabic\c@subsubsubsection}% \ref{} in subsubsubsection

\renewcommand{\@cite}[1]{[#1]}
%\renewcommand{\@biblabel}[1]{#1.} %%Change [1] to 1.

%% command for appendix
\newcommand\startappendix{
  %readjust toc length
  \addtocontents{toc}{\protect\vspace*{0.5cm}}
  \addtocontents{toc}{\protect\setlength{\tocindentchap}{1.4em}}
  \addtocontents{toc}{\protect\gentocwidthparam}                       %regen according to new chapter indent
  \addtocontents{toc}{\protect{\setlength{\tocnwidthchap}{10.0em}}}    %set the nwidth of chapter AFTER generate (to accommodate \appendixname)

  \par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \setcounter{isAppendiced}{1}%
  \renewcommand\@chapapp{\appendixname}%

  \if@thaithesis
    \renewcommand{\thechapter}{\@thaialph\c@chapter}
  \else
    \renewcommand{\thechapter}{\@Alph\c@chapter}
  \fi

  \newpage
  \thispagestyle{empty}
  \centerline{~}
  \vfill
  \ifnum \@numappendices > 1
    \centerline{\Large \appendicespage}
  \else
    \centerline{\Large \appendixpage}
  \fi
  \vfill
  \centerline{~}
}



%%%%%%%%%%%%%%%
% page layout %
%%%%%%%%%%%%%%%
\setlength{\textheight}{25.00cm}       %  text-area height
\geometry{paperwidth=8.27in,paperheight=11.69in,top=1.5in,bottom=1in,left=1.5in,right=1.0in} % set paper size and page margin
\setlength{\headheight}{0.00cm}        %
\setlength{\headsep}{1.00cm}           %
\setlength{\marginparsep}{0.00cm}      %
\setlength{\marginparwidth}{0.00cm}    %
\setlength{\footskip}{0.00cm}          %
\setlength{\parindent}{1.00cm}         %  paragraph indent
\setlength{\parskip}{0.20cm}           %  distance between paragraphs

%%%%%%%%%%%%%%%%%%
% page numbering %
%%%%%%%%%%%%%%%%%%
\def\ps@headings{\def\@oddhead{{\slshape\rightmark}\hfil\if@thaithesis\fi\thepage}}
\pagestyle{myheadings}


\if@thaithesis
  \pagenumbering{thaialph}
\else
  \pagenumbering{roman}
\fi

%%%%%%%%%%%%%%%%%%
% small commands %
%%%%%%%%%%%%%%%%%%
\renewcommand\chapter{
    \selectthesislang
                      \if@openright\cleardoublepage\else\clearpage\fi
                      \thispagestyle{empty}%
                      \global\@topnum\z@   % Prevents figures from going at top of page.
                      \@afterindenttrue
                      \ifnum \c@chapter = 0
                          \ifnum \c@isAppendiced = 0
                            \pagenumbering{arabic}
                            \toccont
                            \addtocontents{toc}{\protect\leftline{\bfseries \chaptername}}
                          \else
                            \toccont
                            \addtocontents{toc}{\protect\vspace*{-0.1cm}}
                            \ifnum \@numappendices > 1
                                \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries \appendicesname}{\@ThaiFont\thepage}}
                            \else
                                \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries \appendixname}{\@ThaiFont\thepage}}
                            \fi
                          \fi
                      \fi
                      \ifnum \c@isAppendiced = 1
                        \addtocontents{toc}{\protect\vspace*{-0.1cm}}
                      \fi

                      \secdef\@chapter\@schapter
}

\def\@chapter[#1]#2{
    \refstepcounter{chapter}
    \toccont
    \addtocontents{toc}{\protect\vspace*{0cm}}
    \ifnum \c@isAppendiced = 0
      \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}
    \else
      \addcontentsline{toc}{chapter}{\appendixname~\protect\numberline{\thechapter}#1}
    \fi
    \@makechapterhead{#2}
    \@afterheading
    \indent
}

\def\@schapter#1{
    {
    \parindent \z@ \centering                % zero indent (\z@ = 0pt}
    \bfseries\Large #1 \par\nobreak
    }
    \@afterheading
    \indent
}

\def\@makechapterhead#1{%
    {
    \parindent \z@ \centering
    \bfseries\Large \MakeUppercase{\@chapapp}
    \ifnum \c@isAppendiced = 0               % test if this chapter is an appendix
        \if@thaithesis
          \@ThaiFont\arabic{chapter}
        \else
          \Roman{chapter}
        \fi
    \else
        \if@thaithesis
          \thalph{chapter}
        \else
          \Alph{chapter}
        \fi
    \fi
    \par\nobreak
    \bfseries\Large \uppercase{#1} \par\nobreak
    }
}

\renewcommand{\section}{
    \toccont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}\@ThaiFont}
    \@startsection{section}{2}{0cm}{0cm}{0.001cm}{\bfseries\large}
}
\renewcommand{\subsection}{
    \toccont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}\@ThaiFont}
    \@startsection{subsection}{3}{0cm}{0cm}{0.001cm}{\bfseries}
}
\renewcommand{\subsubsection}{
    \toccont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}\@ThaiFont}
    \@startsection{subsubsection}{4}{0cm}{0cm}{0.001cm}{\bfseries}
}
\newcommand{\subsubsubsection} {
    \toccont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}}
    \@startsection{subsubsubsection}{5}{0cm}{0cm}{0.001cm}{\bfseries}
}

%%%%%%%%%%%%
% contents %
%%%%%%%%%%%%
\renewcommand\@pnumwidth{0.5cm}        % toc's parameter
\renewcommand\@tocrmarg{1.5cm}         % toc's parameter
\renewcommand\@dotsep{4}               % toc's parameter
\addtocontents{toc}{\protect\rightline{\pagename}}

\newlength{\tocindentchap}
\newlength{\tocnwidthchap}
\newlength{\tocindentsection}
\newlength{\tocnwidthsection}
\newlength{\tocindentsubsection}
\newlength{\tocnwidthsubsection}
\newlength{\tocindentsubsubsection}
\newlength{\tocnwidthsubsubsection}
\newlength{\tocindentsubsubsubsection}
\newlength{\tocnwidthsubsubsubsection}
\newlength{\tocnwidthperstep}
\newlength{\tocnwidthoffset}

\setlength{\tocnwidthperstep}{0.8em}
\setlength{\tocnwidthoffset}{1.4em}
\setlength{\tocindentchap}{0.0em}
\setlength{\tocnwidthchap}{\tocnwidthoffset}

\newcommand{\gentocwidthparam}{
  \setlength{\tocindentsection}{\tocindentchap + \tocnwidthchap}
  \setlength{\tocnwidthsection}{\tocnwidthoffset + \tocnwidthperstep * 1}
  \setlength{\tocindentsubsection}{\tocindentsection + \tocnwidthsection}
  \setlength{\tocnwidthsubsection}{\tocnwidthoffset + \tocnwidthperstep * 2}
  \setlength{\tocindentsubsubsection}{\tocindentsubsection + \tocnwidthsubsection}
  \setlength{\tocnwidthsubsubsection}{\tocnwidthoffset + \tocnwidthperstep * 3}
  \setlength{\tocindentsubsubsubsection}{\tocindentsubsubsection + \tocnwidthsubsubsection}
  \setlength{\tocnwidthsubsubsubsection}{\tocnwidthoffset + \tocnwidthperstep * 3}
}


\gentocwidthparam

\newcommand{\l@nchapter}{\@dottedtocline{0}{0cm}{0cm}}
\renewcommand{\l@chapter}[2]{\@dottedtocline{0}{\tocindentchap}{\tocnwidthchap}{\bfseries #1}{\bfseries #2}}
\renewcommand{\l@section}{\@dottedtocline{1}{\tocindentsection}{\tocnwidthsection}}
\renewcommand{\l@subsection}{\@dottedtocline{2}{\tocindentsubsection}{\tocnwidthsubsection}}
\renewcommand{\l@subsubsection}{\@dottedtocline{3}{\tocindentsubsubsection}{\tocnwidthsubsubsection}}
\newcommand{\l@subsubsubsection}{\@dottedtocline{4}{\tocindentsubsubsubsection}{\tocnwidthsubsubsubsection}}

\renewcommand{\l@table}{\@dottedtocline{0}{0cm}{1.6em}}
\renewcommand{\l@figure}{\@dottedtocline{0}{0cm}{2.4em}}

\renewcommand{\tableofcontents}{
    \selectthesislang
    \thispagestyle{empty}
    \toccont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}}
    \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries \contentsname}{\@ThaiFont\thepage}}
    \centerline{\bfseries\Large \contentsname}
    \@starttoc{toc}
}
\newcommand{\toccont}{
    \addtocontents{toc}{
        \protect\setlength{\protect\pageleft}{\protect\textheight - \protect\pagetotal}
        \protect\ifdim \protect\pageleft < 1cm
            \protect\newpage
            \protect\centerline{\bfseries\Large }
            {\hspace{-1cm}\chaptername\hfill\pagename\hspace{-0.1cm}}
        \protect\fi
    }
}

%%%%%%%%%%%%%%%%%
% list of table %
%%%%%%%%%%%%%%%%%
\setlength{\arraycolsep}{5\p@}            % tabular's parameter
\setlength{\tabcolsep}{6\p@}              % tabular's parameter
\setlength{\arrayrulewidth}{.4\p@}        % tabular's parameter
\setlength{\doublerulesep}{2\p@}          % tabular's parameter
\renewcommand{\arraystretch}{1.0}         % tabular's parameter
\renewcommand{\thetable}{\ifnum\c@chapter>\z@\thechapter.\fi\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}

\renewenvironment{table}{
    \@float{table}
}{
    \lotcont
    \end@float
}

\setlength{\abovecaptionskip}{10\p@}
\setlength{\belowcaptionskip}{10\p@}
\long\def\@makecaption#1#2{
\vskip\abovecaptionskip
\sbox\@tempboxa{#1: #2}
\ifdim \wd\@tempboxa > \hsize
    #1: #2\par
\else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}
\fi
\vskip\belowcaptionskip}

\renewcommand{\listoftables}{
    \toccont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}}
    \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries \listtablename}{\@ThaiFont\thepage}}
    \centerline{\bfseries\Large \listtablename}
    \@starttoc{lot}
    \addtocontents{lot}{\hspace{-1cm}\tablename\hfill\pagename\hspace{-0.1cm}}
    \addtocontents{lot}{\protect\setlength{\parskip}{0.0cm}}           %  distance between paragraphs
}

\newcommand{\lotcont}{
    \addtocontents{lot}{
        \protect\setlength{\protect\pageleft}{\protect\textheight - \protect\pagetotal}
        \protect\ifdim \protect\pageleft < 1cm
            \protect\newpage
            {\hspace{-1cm}\tablename\hfill\pagename\hspace{-0.1cm}}
        \protect\fi
        }
}

%%%%%%%%%%%%%%%%%%%
% list of figures %
%%%%%%%%%%%%%%%%%%%
\renewcommand{\thefigure}{\ifnum\c@chapter>\z@\thechapter.\fi\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}

\renewenvironment{figure}{
    \@float{figure}
}{
    \lofcont
    \end@float
}

\renewcommand{\listoffigures}{
    \toccont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}}
    \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries \listfigurename}{\@ThaiFont\thepage}}
    \addtocontents{toc}{\protect\vspace*{0.5cm}}
    \centerline{\bfseries\Large \listfigurename}
    \@starttoc{lof}
    \addtocontents{lof}{\hspace{-1cm}\figurename\hfill\pagename\hspace{-0.1cm}}

    %% my new attempt
    \addtocontents{lof}{\protect\setlength{\parskip}{0.0cm}}           %  distance between paragraphs

    \addtocontents{lof}{\protect\thispagestyle{myheadings}}

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % save number of roman pages %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \addtocounter{TotalPage}{\arabic{page}}
}

\newcommand{\lofcont}{
    \addtocontents{lof}{
        \protect\setlength{\protect\pageleft}{\protect\textheight - \protect\pagetotal}
        \protect\ifdim \protect\pageleft < 1cm
            \protect\newpage
            {\hspace{-1cm}\figurename\hfill\pagename\hspace{-0.1cm}}
       \protect\fi
    }
}

%%%%%%%%%%%%
% equation %
%%%%%%%%%%%%
\@addtoreset{equation}{chapter}
\renewcommand{\theequation}{\ifnum\c@chapter>\z@\thechapter.\fi\@arabic\c@equation}

%%%%%%%%%%%%%
% emphasize %
%%%%%%%%%%%%%
\newcommand\e[1]{{\normalem \emph{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Front matter commands
%%
%% These commands generate the first few pages of the thesis, such as
%% Thai Title, English Title, Committee Page, Abstract,
%% Acknowledgement, etc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\makethaicover}{
    %\fontsize{11}{15}\selectfont
    \large
    \thispagestyle{empty}
    \centerline{ \begin{tabular}{p{14cm}}\centering\@ThaiTitle\end{tabular} }
    \centerline{ \begin{tabular}{p{14cm}}\centering\@EnglishTitle\end{tabular}}
    \vfill

    \centerline{\@ThaiAuthorTitle\@ThaiAuthor}
    \vspace{1cm}
    \vfill

    \begin{center}
{\@ThaiBookTitle}นี้เป็นส่วนหนึ่งของการศึกษา \\
หลักสูตร{\@ThaiDegree} สาขาวิชา{\@ThaiFieldOfStudy} \\
ภาควิชา{\@ThaiDept} คณะ{\@ThaiFaculty} \\
มหาวิทยาลัยอุบลราชธานี \\
ปีการศึกษา {\begin{english}\@ThaiAcademicYear\end{english}}\\
ลิขสิทธิ์ของมหาวิทยาลัยอุบลราชธานี
    \end{center}
    \normalsize
}

\newcommand{\makeenglishcover}{
    \fontsize{11}{15}\selectfont
    \thispagestyle{empty}
    \centerline{\begin{tabular}{p{14cm}}\centering\@EnglishTitle\end{tabular}}
    \vfill
    \centerline{\@EnglishAuthorTitle~\@EnglishAuthor}
    \vfill
    \begin{center}
A {\@EnglishBookTitle} Submitted in Partial Fulfillment of the Requirements \\
for the Degree of {\@EnglishDegree} Program in {\@EnglishFieldOfStudy} \\
Department of {\@EnglishDept} \\
Faculty of {\@EnglishFaculty} \\
Ubon Ratchathani University \\
Academic Year {\@EnglishAcademicYear} \\
Copyright of Ubon Ratchathani University
\end{center}
}


\newcommand{\ThaiCommittee}[1]{
    \fontsize{11}{13.2}\selectfont
    \thispagestyle{empty}
    \noindent

    \begin{tabular}{@{}p{3.8cm}p{0.5cm}p{9.2cm}}
    {{\@ThaiBookTitle}}   & : & \@ThaiTitle \\

    {}   & {} & \@EnglishTitle \\
    {โดย}                                & : & \@ThaiAuthorTitle\@ThaiAuthor \\
    {อาจารย์ที่ปรึกษา}                   & : & \@ThaiAdvisorShort \\
    \if@coadvisor
    {อาจารย์ที่ปรึกษาร่วม}               & : & \@ThaiCoAdvisor \\
    \fi
    {ระดับการศึกษา}                      & : & {\@ThaiDegree} สาขาวิชา{\@ThaiFieldOfStudy} \\
    {ปีการศึกษา}                      & : & \@ThaiAcademicYear \\
    \end{tabular}

    \vspace*{0.4cm}
    \hrule width 15 cm height 0.0 cm depth 0.025 cm

    \begin{center}
    {\bfseries
    ได้รับการพิจารณาให้เป็นส่วนหนึ่งของการศึกษา \\
    ตามหลักสูตร{\@ThaiDegree} สาขา{\@ThaiFieldOfStudy}  \\
    }
    \end{center}

    %\if@ugrad {ภาควิชา\@ThaiDept} \fi {คณะ\@ThaiFaculty} {มหาวิทยาลัยอุบลราชธานี} {อนุมัติให้นับ{\@ThaiBookTitle}ฉบับนี้เป็นส่วนหนี่งของการศึกษาตามหลักสูตร{\@ThaiDegreeType}} \if@ugrad ในรายวิชา {\@subjID} {\@ThaiSubjName} \fi

%    \vspace*{0.3cm}

    \noindent
    \hspace*{1.5cm} {\bfseries คณะกรรมการสอบประเมินความรู้โครงงานคอมพิวเตอร์}

    \noindent
    \begin{tabular}{p{3cm}>{\centering\arraybackslash}p{6cm}l}
    \@Committee
    \end{tabular}

    \noindent
    \begin{tabular}{p{3cm}>{\centering\arraybackslash}p{6cm}l}
    \hspace*{0.5cm} & \hspace*{8.0cm} & \\
                    & \dotfill & {\if@ugrad{หัวหน้าภาควิชา}\else{คณบดีคณะ{\@ThaiFaculty}}\fi} \\
                    & {(\@ThaiDeanName)}
    \end{tabular}

    \noindent
    \begin{tabular}{p{3cm}>{\centering\arraybackslash}p{6cm}l}
    \hspace*{0.5cm} & \hspace*{8.0cm} & \\
                    & วันที่\fillin[1cm]/\fillin[1cm]/\fillin[1cm] &  {}
    \end{tabular}

}

\newcommand{\EnglishCommittee}{
    \fontsize{11}{13.2}\selectfont
    \setlength{\textwidth}{16.50cm}
    \thispagestyle{empty}
    \noindent
    \begin{tabular}{p{3cm}p{11cm}}
    \@EnglishBookTitle Title            & \@EnglishTitle \\
    By                      & \@EnglishAuthorTitle\@EnglishAuthor \\
    Field of Study          & \@EnglishFieldOfStudy \\
    \@EnglishBookTitle~Advisor          & \@EnglishAdvisor \\
    \if@coadvisor
    \@EnglishBookTitle~Co-advisor       & \@EnglishCoAdvisor \\
    \fi
    \end{tabular}

    \vspace*{0.4cm}
    \hrule width 15 cm height 0.0 cm depth 0.025 cm

    Accepted by the \if@ugrad Department of \@EnglishDept\fi Faculty of \@EnglishFaculty, Ubon Ratchathani University in Partial Fulfillment of the Requirements for the \@EnglishDegreeType \if@ugrad in {\@subjID} {\@EnglishSubjName}\fi

    \noindent
    \begin{tabular}{p{3cm}p{6cm}>{\raggedright\arraybackslash}p{4.5cm}}
                    \hspace*{0.5cm} & \hspace*{8.0cm} & \\
                    & \dotfill & Dean of the {\if@ugrad{Department of \@EnglishDept}\else{Faculty of \@EnglishFaculty}\fi} \\
                    & \multicolumn{2}{l}{(\@EnglishDeanName)}
    \end{tabular}

    \vspace*{0.4cm}

    \noindent
    \if@ugrad{PROJECT}\else{THESIS}\fi~COMMITTEE

    \noindent
    \begin{tabular}{p{3cm}>{\centering\arraybackslash}p{6cm}l}
    \@Committee
    \end{tabular}
    \setlength{\textwidth}{15.00cm}
}

\newcommand{\makecommittee} {
  \protect\if@thaithesis
     \ThaiCommittee
  \protect\else
     \EnglishCommittee
  \protect\fi
}

\newcommand{\CommitteeBlock}[2] {
    \hspace*{0.5cm} & \hspace*{8.0cm} & \\
    & \dotfill & {#1} \\
    & {(#2)} \\
}

\newcommand{\CommitteeBlockAdvisor} {
    \hspace*{0.5cm} & \hspace*{8.0cm} & \\
    & \dotfill & {\if@thaithesis {อาจารย์ที่ปรึกษา} \else \@EnglishBookTitle~Advisor \fi} \\
    & (\if@thaithesis \@ThaiAdvisorShort \else \@EnglishAdvisor \fi) \\
}

\newcommand{\CommitteeBlockCoAdvisor} {
    \if@coadvisor
    \hspace*{0.5cm} & \hspace*{8.0cm} & \\
    & \dotfill & {\if@thaithesis {อาจารย์ที่ปรึกษาร่วม} \else {\@EnglishBookTitle}~Co-advisor \fi} \\
    & (\if@thaithesis \@ThaiCoAdvisorShort \else \@EnglishCoAdvisor~ \fi) \\
    \fi
}


%%environment for multiple paragraph page such as abstract and acknowledgement
\newenvironment{thaiabstract}{
    \fontsize{11}{15}\selectfont
    \thispagestyle{headings}
    \toccont
    \@ThaiFont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}}
    \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries\@AbstractThaiString}{\@ThaiFont\thepage}}
    \noindent
    \begin{tabular}{@{}p{3.8cm}p{0.5cm}p{9.2cm}}
    {{\@ThaiBookTitle}}   & : & \@ThaiTitle \\

    %{}   & {} & \@EnglishTitle \\
    {โดย}                                & : & \@ThaiAuthorTitle\@ThaiAuthor \\
    {อาจารย์ที่ปรึกษา}                   & : & \@ThaiAdvisorShort \\
    \if@coadvisor
    {อาจารย์ที่ปรึกษาร่วม}               & : & \@ThaiCoAdvisor \\
    \fi
    {ระดับการศึกษา}                      & : & {\@ThaiDegree} สาขาวิชา{\@ThaiFieldOfStudy} \\
    {ปีการศึกษา}                      & : & \@ThaiAcademicYear \\
    \end{tabular}
    \vspace*{0.4cm}
    \hrule width 15 cm height 0.0 cm depth 0.025 cm
    \vspace*{0.4cm}
    \centerline{\bfseries\Large บทคัดย่อ}
    \normalsize
}


\newenvironment{englishabstract}{
    \fontsize{11}{15}\selectfont
    \thispagestyle{headings}
    \toccont
    \@ThaiFont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}}
    \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries\@AbstractEnglishString}{\@ThaiFont\thepage}}
    \noindent
    \begin{tabular}{@{}p{3.8cm}p{0.5cm}p{9.2cm}}
    {Topic}   & : & \@EnglishTitle \\

    %{}   & {} & \@EnglishTitle \\
    {Author}                                & : & \uppercase{\@EnglishAuthorUP} \\
    {Advisor}                   & : & \@EnglishAdvisorShort \\
    \if@coadvisor
    {Co-advisor}               & : & \@EnglishCoAdvisorShort \\
    \fi
    {Degree}                      & : & {\@EnglishDegree} ({\@EnglishFieldOfStudy}) \\
    {Academic Year}                      & : & \@EnglishAcademicYear \\
    \end{tabular}
    \vspace*{0.4cm}
    \hrule width 15 cm height 0.0 cm depth 0.025 cm
    \vspace*{0.4cm}
    \centerline{\bfseries\Large Abstract}
    \normalsize
}


\newenvironment{englishabstract2}{
%    \selectthesislang
    \fontsize{11}{15}\selectfont
    \thispagestyle{headings}
    \toccont
    \@ThaiFont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}}
    \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries \@AbstractEnglishString}{\@ThaiFont\thepage}}
    \noindent
    \#\# \@AuthorID : MAJOR \uppercase{\@EnglishFieldOfStudyUP} \\
    KEYWORDS: \@KeywordsEnglish

    \vspace{-\parskip}
    \hangindent = 1.0 cm \hangafter = 1
    \uppercase{\@EnglishAuthorUP} : \@EnglishTitle. ADVISOR : \uppercase{\@EnglishAdvisorShort},
    {\if@coadvisor \MakeUppercase{\@EnglishBookTitle} COADVISOR : \uppercase{\@EnglishCoAdvisorShort},\fi } \ref{@TheLastPage} pp.

    } {
    \vfill

    \noindent
    \begin{tabular}{l@{}p{6.2cm}p{5.6cm}@{}}
        & \\
        Department &:       {\@EnglishDept}\dotfill & Student's Signature \dotfill \\
        Field of Study &:   {\@EnglishFieldOfStudy}\dotfill & Advisor's Signature \dotfill \\
        Academic Year &:     {\@EnglishAcademicYear}\dotfill           &
        \if@coadvisor
        Co-advisor's signature \dotfill \\
        \fi
    \end{tabular}
}

\newenvironment{acknowledgements}{
    \selectthesislang
    \fontsize{11}{15}
    \toccont
    \addtocontents{toc}{\protect\vspace*{-0.1cm}}
    \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries \@AcknowledgementsString}{\@ThaiFont\thepage}}
    \centerline{\bfseries\Large \@AcknowledgementsString}

    \noindent
    \hfill
    \hspace*{1.0cm}

    \normalfont
}


\newenvironment{biography}{
    \selectthesislang
    \newpage
    \toccont
    \addtocontents{toc}{\protect\vspace*{0.5cm}}
    \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries \@BiographyString}{\@ThaiFont\thepage}}
    \centerline{\bfseries\Large \@BiographyString}
    } {
    %%%%%%%%%%%%%%%%%%%%%
    % compute TotalPage %
    %%%%%%%%%%%%%%%%%%%%%
    \addtocounter{TotalPage}{\arabic{page}}
    \addtocounter{TotalPage}{-1}
    \refstepcounter{TotalPage}
    \label{@TheLastPage}
}

\newcommand\thereferences{
    \toccont
    \addtocontents{toc}{\protect\vspace*{0.5cm}}
    \addtocontents{toc}{\protect\contentsline{nchapter}{\bfseries \bibname}{\@ThaiFont\thepage}\vspace*{0.5cm}}
}

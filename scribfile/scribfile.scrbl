#lang scribble/manual

@(require "scribfile.rkt"
          (for-label racket))

@title{Scribfile: File and Operating System related Scribble Functionality}

@section{File Loading}

@subsection{lispblock0}

@defform[(lispblock0 options ... path)]{
                                       
Responsible for creating a @racket[codeblock0] form using the contents of 
a file containing a LISPy programming language. See @racket[codeblock0]
for documentation on the options; @racket[path] is a string.}

If you want to use Scribble for non-Racket languages, this is a decent
substitute; you get the power of Scribble with only a little loss of 
functionality. For example, to load some JESS code, the following:

@codeblock0|{@lispblock0{sample.clp}}|

results in:
 
@lispblock0{sample.clp}

@section{File Execution}

@subsection{systemout}

@defform[(systemout command)]{
                                       
Responsible for creating a @racket[verbatim] form by capturing the STDOUT and
STDERR of the process created by calling @racket[system] on @racket[command], a string.}

If you want to capture the results of arbitrary commands, then this is a simple way
to do it. For example on Linux:

@codeblock0|{@systemout["uname -a"]}|

results in:

@verbatim{Linux stargate 3.2.0-35-generic #55-Ubuntu SMP Wed Dec 5 17:42:16 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux}
#lang scribble/manual

@(require "scribfile.rkt"
          (for-label racket))

@title{Scribfile: File and Operating System related Scribble Functionality}

@author+email["Grant Rettke" "grettke@acm.org"]

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
STDERR of the process created by calling @racket[system] on @racket[command], a string.

It works on Linux, but not Windows (use @racket[systemout*] instead).}

If you want to capture the results of arbitrary commands, then this is a simple way
to do it. For example on Linux:

@codeblock0|{@systemout["~/git/scribfile/scribfile/test.sh"]}|

results in:

@verbatim{This is a message going to STDOUT.
This is a message going to STDERR.}

@subsection{systemout*}

@defform[(systemout* command args ...)]{
                                       
Responsible for creating a @racket[verbatim] form by capturing the STDOUT and
STDERR of the process created by calling @racket[system*] on @racket[command], a string,
and @racket[args], 0-or-more strings.

It works on Linux and Windows.}

@codeblock0|{@systemout*["/bin/ls" "-a" "-l"]}|

results in:

@verbatim{total 88
drwxrwxr-x 4 gcr gcr  4096 Jan 15 12:14 .
drwxr-xr-x 4 gcr gcr  4096 Jan 14 20:47 ..
drwxrwxr-x 3 gcr gcr  4096 Jan 14 20:25 compiled
-rw-rw-r-- 1 gcr gcr   104 Jan 14 20:41 .gitignore
-rw-rw-r-- 1 gcr gcr  1893 Jan 15 10:58 info.rkt
-rw-rw-r-- 1 gcr gcr  2341 Jan 14 20:29 info.rkt~
drwxrwxr-x 3 gcr gcr  4096 Jan 14 20:35 planet-docs
-rw-rw-r-- 1 gcr gcr  2964 Jan 14 16:20 racket.css
-rw-rw-r-- 1 gcr gcr   197 Jan 14 20:13 sample.clp
-rw-rw-r-- 1 gcr gcr  5062 Jan 14 16:05 scribble-common.js
-rw-rw-r-- 1 gcr gcr  7697 Jan 14 16:05 scribble.css
-rw-rw-r-- 1 gcr gcr     0 Jan 14 16:05 scribble-style.css
-rw-rw-r-- 1 gcr gcr 12412 Jan 15 11:25 scribfile.html
-rw-rw-r-- 1 gcr gcr  1811 Jan 15 12:20 scribfile.rkt
-rw-rw-r-- 1 gcr gcr    19 Jan 14 15:45 scribfile.rkt~
-rw-rw-r-- 1 gcr gcr  1785 Jan 15 12:32 scribfile.scrbl
-rw-rw-r-- 1 gcr gcr    23 Jan 14 16:03 scribfile.scrbl~
-rwxrwxr-x 1 gcr gcr    98 Jan 15 10:57 test.sh}
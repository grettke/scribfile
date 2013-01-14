#lang racket

(provide fileblock)

(require (for-syntax racket/port)
         scribble/manual)

(define-for-syntax (sf:path->string path)
  (define fis (open-input-file #:mode 'text path))
  (define result (port->string fis))
  (close-input-port fis)
  result)

(define-syntax (fileblock stx) 
  (syntax-case stx ()
    [(_ option ... path)
     (with-syntax ([contents (datum->syntax #'_ (sf:path->string (syntax->datum #'path)))])
       #'(codeblock option ... contents))]))
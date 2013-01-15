#lang racket

(provide lispblock0
         systemout)

(require (for-syntax racket/port
                     racket/system)
         scribble/manual)

(define-for-syntax (sf:path->string path)
  (define fis (open-input-file #:mode 'text path))
  (define result (port->string fis))
  (close-input-port fis)
  result)

(define-syntax (lispblock0 stx) 
  (syntax-case stx ()
    [(_ option ... path)
     (with-syntax ([contents (datum->syntax #'_ (sf:path->string (syntax->datum #'path)))])
       #'(codeblock0 option ... contents))]))

(define-for-syntax (system-call command)
  (let ((cop (open-output-string))
        (cep (open-output-string)))
    (parameterize ((current-output-port cop)
                   (current-error-port cep))
      (system command))
    (map get-output-string (list cop cep))))

(define-syntax (systemout stx)
  (syntax-case stx ()
    [(_ command)
     (with-syntax ([(out err) 
                    (map (lambda (dtm) (datum->syntax #'_ dtm)) 
                         (system-call (syntax->datum #'command)))])
         #'(verbatim out err))]))
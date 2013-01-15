#lang racket

(provide lispblock0
         systemout
         systemout*)

(require (for-syntax racket/port
                     racket/system)
         scribble/manual)

(define-for-syntax (sf:path->string path)
  (let ((fis #f)
        (result #f))
    (call-with-exception-handler
     (lambda (exn)
       (close-input-port fis)
       (set! result (format "Error: ~a~n" (if (exn? exn) (exn-message exn) exn))))
     (lambda ()
       (set! fis (open-input-file #:mode 'text path))
       (set! result (port->string fis))))
    (close-input-port fis)
    result))

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
      (call-with-exception-handler 
       (lambda (exn) (printf "Error: ~a~n" (if (exn? exn) (exn-message exn) exn)))
       (lambda () (system command))))
    (map get-output-string (list cop cep))))

(define-syntax (systemout stx)
  (syntax-case stx ()
    [(_ command)
     (with-syntax ([(out err) 
                    (map (lambda (dtm) (datum->syntax #'_ dtm)) 
                         (system-call (syntax->datum #'command)))])
       #'(verbatim out err))]))

(define-for-syntax (system*-call command stx-args)
  (let ((cop (open-output-string))
        (cep (open-output-string))
        (args (map (lambda (stx) (syntax->datum stx)) stx-args)))
    (parameterize ((current-output-port cop)
                   (current-error-port cep))  
      (call-with-exception-handler
       (lambda (exn) (printf "Error: ~a~n" (if (exn? exn) (exn-message exn) exn)))
       (lambda () (apply system* command args))))
    (let ((result (map get-output-string (list cop cep))))
      (display result)
      result)))

(define-syntax (systemout* stx)
  (syntax-case stx ()
    [(_ command arg ...)
     (with-syntax ([(out err) 
                    (map (lambda (dtm) (datum->syntax #'_ dtm)) 
                         (system*-call (syntax->datum #'command) (syntax->list #'(arg ...))))])
       #'(verbatim out err))]))
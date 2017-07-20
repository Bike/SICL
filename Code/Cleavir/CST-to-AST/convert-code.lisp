(cl:in-package #:cleavir-cst-to-ast)

;;; The general method for processing the lambda list is as follows:
;;; We use recursion to process the remaining lambda list.  Before the
;;; recursive call, we add the current parameters to the environment
;;; that we pass to the recursive call.  The call returns two values:
;;; the AST that was built and a modified lambda list, containing the
;;; lambda list keywords, and the lexical variables that were
;;; introduced.  The exception is that processing &AUX entries does
;;; not return any lambda list, because it will always be empty.
;;;
;;; The reason we do it this way is that, if a parameter turns out to
;;; be a special variable, the entire rest of the lambda list and
;;; function body must be executed with this variable bound.  The AST
;;; configuration for expressing that situation is that the AST for
;;; computing the rest of the lambda list and the body must be a child
;;; of a BIND-AST that indicates that the special variable should be
;;; bound.  This recursive method makes sure that the child exists
;;; before the BIND-AST is created.
;;;
;;; The parameter DSPECS that is used in several functions is a list
;;; of canonicalized declaration specifiers.  This list is used to
;;; determine whether a variable is declared special.

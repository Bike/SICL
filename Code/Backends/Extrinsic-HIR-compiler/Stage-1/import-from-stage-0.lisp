(cl:in-package #:sicl-extrinsic-hir-compiler)

;;; In order to define functions in *ENVIRONMENT-1*, we already need
;;; to have definitions of some functions. 

;;; The functions LIST and APPEND are needed because they are
;;; generated by the backquote reader macro, and the backquote reader
;;; macro is used by the expansion of DEFUN to set the function type.
(setf (sicl-global-environment:fdefinition 'list *environment-1*)
      (sicl-global-environment:fdefinition 'list *environment*))

(setf (sicl-global-environment:fdefinition 'append *environment-1*)
      (sicl-global-environment:fdefinition 'append *environment*))

;;; The function FUNCALL is used as a result of the expansion of SETF,
;;; so it is needed as well.
(setf (sicl-global-environment:fdefinition 'funcall *environment-1*)
      (sicl-global-environment:fdefinition 'funcall *environment*))

;;; The function (SETF FUNCTION-TYPE) is used in the expansion of DEFUN.
(setf (sicl-global-environment:fdefinition
       '(setf sicl-global-environment:function-type)
       *environment-1*)
      (sicl-global-environment:fdefinition
       '(setf sicl-global-environment:function-type)
       *environment*))

;;; The function (SETF FDEFINITION) is what makes it possible to add
;;; new function definitions, so we need it too.
(setf (sicl-global-environment:fdefinition
       '(setf sicl-global-environment:fdefinition)
       *environment-1*)
      (sicl-global-environment:fdefinition
       '(setf sicl-global-environment:fdefinition)
       *environment*))

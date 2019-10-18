(cl:in-package #:sicl-boot-phase-6)

(defun load-data-and-control-flow-code (e5)
  (load-fasl "Data-and-control-flow/eq-defun.fasl" e5)
  (load-fasl "Data-and-control-flow/defun-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/fdefinition-defun.fasl" e5)
  (load-fasl "Data-and-control-flow/setf-fdefinition-defun.fasl" e5)
  (load-fasl "Data-and-control-flow/fboundp-defun.fasl" e5)
  (load-fasl "Data-and-control-flow/fmakunbound-defun.fasl" e5)
  (load-fasl "Data-and-control-flow/functionp-defgeneric.fasl" e5)
  (load-fasl "Data-and-control-flow/functionp-defmethods.fasl" e5)
  (load-fasl "Data-and-control-flow/defconstant-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/defparameter-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/defvar-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/return-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/psetf-support.fasl" e5)
  (load-fasl "Data-and-control-flow/psetf-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/psetq-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/destructuring-bind-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/rotatef-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/shiftf-support.fasl" e5)
  (load-fasl "Data-and-control-flow/shiftf-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/multiple-value-list-defmacro.fasl" e5)
  (load-fasl "Data-and-control-flow/get-setf-expansion-defun.fasl" e5))

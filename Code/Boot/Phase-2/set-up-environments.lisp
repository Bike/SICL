(cl:in-package #:sicl-boot-phase-2)

(defun set-up-environments (boot)
  (with-accessors ((e2 sicl-boot:e2)
                   (e3 sicl-boot:e3))
      boot
    (sicl-boot:import-function-from-host 'funcall e2)
    (sicl-boot:import-function-from-host 'cons e2)
    (sicl-boot:import-function-from-host 'funcall e3)
    (sicl-boot:import-function-from-host '(setf sicl-genv:function-lambda-list) e3)
    (sicl-boot:import-function-from-host '(setf sicl-genv:function-type) e3)
    (sicl-hir-interpreter:fill-environment e2)
    (sicl-hir-interpreter:fill-environment e3)
    (sicl-boot:import-function-from-host 'list e2)))

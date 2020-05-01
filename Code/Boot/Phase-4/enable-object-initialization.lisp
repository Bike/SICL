(cl:in-package #:sicl-boot-phase-4)

(defun enable-object-initialization (boot)
  (with-accessors ((e3 sicl-boot:e3)
                   (e4 sicl-boot:e4)) boot
    ;; The support code for SHARED-INITIALIZE in phase 3 will need to
    ;; access various slots of class metaobjects and slot-definition
    ;; metaobjects.  Since we are initializing objects in E4, the
    ;; class metaobjects for these objects are located in E3.
    ;; Therefor, it is handy to load the support code for
    ;; SHARED-INITIALIZE into E3.  Notice, however, that we do not
    ;; want to define SHARED-INITIALIZE itself in E3 because we
    ;; already have a definition for it there (imported from the
    ;; host), and we do want to call SHARED-INITIALIZE from functions
    ;; in E4.
    (setf (sicl-genv:special-variable 'sicl-clos:+unbound-slot-value+ e3 t)
          10000000)
    (load-fasl "CLOS/slot-bound-using-index.fasl" e3)
    (load-fasl "CLOS/slot-value-etc-defgenerics.fasl" e3)
    (load-fasl "CLOS/slot-value-etc-support.fasl" e3)
    (load-fasl "CLOS/slot-value-etc-defmethods.fasl" e3)
    (load-fasl "CLOS/instance-slots-offset-defconstant.fasl" e3)
    (load-fasl "CLOS/shared-initialize-support.fasl" e3)
    ;; Instead of loading the file containing the definition of
    ;; SHARED-INITIALIZE-DEFAULT, we define our own version here
    ;; so that we can have it call the main workhorse function
    ;; SHARED-INITIALIZE-DEFAULT-USING-CLASS-AND-SLOTS in E3.
    (setf (sicl-genv:fdefinition 'sicl-clos::shared-initialize-default e4)
          (lambda (instance slot-names &rest initargs)
            (let* ((class-of (sicl-genv:fdefinition 'class-of e4))
                   (class (funcall class-of instance))
                   (class-slots (sicl-genv:fdefinition 'sicl-clos:class-slots e3))
                   (slots (funcall class-slots class)))
              (apply (sicl-genv:fdefinition
                      'sicl-clos::shared-initialize-default-using-class-and-slots
                      e3)
                     instance slot-names class slots initargs))))
    (load-fasl "CLOS/shared-initialize-defgenerics.fasl" e4)
    (load-fasl "CLOS/shared-initialize-defmethods.fasl" e4)
    (load-fasl "CLOS/initialize-instance-support.fasl" e4)
    (load-fasl "CLOS/initialize-instance-defgenerics.fasl" e4)
    (load-fasl "CLOS/initialize-instance-defmethods.fasl" e4)
    (load-fasl "CLOS/make-instance-support.fasl" e3)
    (sicl-boot:define-make-instance e3 e4)))

(cl:in-package #:sicl-clos)

;;; At the moment, this macro does not have any compile-time side
;;; effects.

;;; CT-ENV is the compile-time environment in which the call to
;;; DEFMETHOD is compiled.  We check the compile-time environment to
;;; see whether there is a generic function named FUNCTION-NAME in it.
;;; If there is such a generic function, it is used as the first
;;; argument to MAKE-METHOD-LAMBDA, and the CLASS-PROTOTYPE of the
;;; GENERIC-FUNCTION-METHOD-CLASS of that function is used as the
;;; second argument to MAKE-METHOD-LAMBDA.  If no such generic
;;; function is found, we use the CLASS-PROTOTYPE of the class named
;;; STANDARD-GENERIC-FUNCTION in CT-ENV as the first argument to
;;; MAKE-METHOD-LAMBDA, and we use the CLASS-PROTOTYPE of the class
;;; named STANDARD-METHOD in CT-ENV as the second argument to
;;; MAKE-METHOD-LAMBDA.
;;;
;;; The expansion of this macro calls the SICL-specific function
;;; ENSURE-METHOD.  The first argument to ENSURE-METHOD is the generic
;;; function named FUNCTION-NAME in the run-time environment (and not
;;; in the compile-time environment) in which the expansion is
;;; evaluated.  The second argument to ENSURE-METHOD is the run-time
;;; environment itself.  The function ENSURE-METHOD uses the
;;; environment argument to take symbols naming specializers and to
;;; look up the corresponding classes.
;;;
;;; During bootstrapping, the expansion of this macro needs to call
;;; ENSURE-METHOD in a different environment from the one in which the
;;; DEFMACRO form was evaluated.  For that reason, we use an
;;; indirection called ENSURE-METHOD-ON-GENERIC-FUNCTION.  In the
;;; final system, this function simply trampolines to ENSURE-METHOD in
;;; the same environment, but during bootstrapping, it trampolines to
;;; ENSURE-METHOD in the preceding environment.

(defun parse-defmethod (all-but-name)
  (let* ((lambda-list-position (position-if #'listp all-but-name))
         (qualifiers (subseq all-but-name 0 lambda-list-position))
         (lambda-list (elt all-but-name lambda-list-position))
         (body (subseq all-but-name (1+ lambda-list-position)))
         (parsed-lambda-list
           (cleavir-code-utilities:parse-specialized-lambda-list lambda-list))
         (required (cleavir-code-utilities:required parsed-lambda-list)))
    (multiple-value-bind (declarations documentation forms)
        (cleavir-code-utilities:separate-function-body body)
      (values qualifiers
              (mapcar #'car required)
              (subseq lambda-list (length required))
              (mapcar #'cadr required)
              declarations
              documentation
              forms))))

(defun canonicalize-specializer (specializer)
  (cond ((symbolp specializer)
         `',specializer)
        ((and (consp specializer)
              (consp (cdr specializer))
              (null (cddr specializer)))
         `(make-instance 'eql-specializer :object ,(cadr specializer)))
        (t
         (error 'malformed-specializer :specializer specializer))))

(defun canonicalize-specializers (specializers)
  `(list ,@(mapcar #'canonicalize-specializer specializers)))

(defun defmethod-expander (ct-env function-name rest)
  (multiple-value-bind
        (qualifiers required remaining specializers declarations documentation forms)
      (parse-defmethod rest)
    (let* ((lambda-list (append required remaining))
           (generic-function-var (gensym)))
      `(let* ((rt-env (sicl-genv:global-environment))
              (,generic-function-var
                (ensure-generic-function ',function-name :environment rt-env)))
         (ensure-method-on-generic-function
          ,generic-function-var
          :lambda-list ',lambda-list
          :qualifiers ',qualifiers
          :specializers ,(canonicalize-specializers specializers)
          :documentation ,documentation
          :function
          ,(create-method-lambda
            function-name
            `(lambda ,lambda-list
               ,@declarations
               ,@forms)
            ct-env))))))

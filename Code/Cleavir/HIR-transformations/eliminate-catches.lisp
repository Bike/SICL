(in-package #:cleavir-hir-transformations)

;;;; Eliminates CATCH-INSTRUCTIONS with unused continuations.
;;;; Because they have multiple successors, this is not suitable
;;;; for inclusion in the general remove-useless-instructions.

(defun eliminate-catches (initial-instruction)
  (let ((death nil))
    (cleavir-ir:map-instructions-arbitrary-order
     (lambda (instruction)
       (when (typep instruction 'cleavir-ir:catch-instruction)
         (let ((cont (first (cleavir-ir:outputs instruction))))
           (when (null (cleavir-ir:using-instructions cont))
             (push instruction death)))))
     initial-instruction)
    (dolist (catch death)
      ;; We replace each catch with an assignment (of the dynamic environment).
      (let* ((cleavir-ir:*origin* (cleavir-ir:origin catch))
             (cleavir-ir:*policy* (cleavir-ir:policy catch))
             (cleavir-ir:*dynamic-environment*
               (cleavir-ir:dynamic-environment catch))
             (asn (cleavir-ir:make-assignment-instruction
                   (cleavir-ir:dynamic-environment catch)
                   (second (cleavir-ir:outputs catch))))
             (succ (first (cleavir-ir:successors catch))))
        (cleavir-ir:insert-instruction-between asn catch succ)
        (cleavir-ir:bypass-instruction asn catch)))
    death))

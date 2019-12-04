(cl:in-package #:cleavir-ir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction SIGNED-ADD-INSTRUCTION

(defclass signed-add-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction signed-add-instruction) slot-names
     &rest keys
     &key
       inputs augend addend
       outputs output
       successors normal-successor overflow-successor)
  (assert (all-or-none augend addend))
  (assert (all-or-none normal-successor overflow-successor))
  (let ((inputs (combine inputs augend addend))
        (outputs (if (null output) outputs (list output)))
        (successors (combine successors normal-successor overflow-successor)))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction SIGNED-SUB-INSTRUCTION

(defclass signed-sub-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction signed-sub-instruction) slot-names
     &rest keys
     &key
       inputs minuend subtrahend
       outputs output
       successors normal-successor overflow-successor)
  (assert (all-or-none minuend subtrahend))
  (assert (all-or-none normal-successor overflow-successor))
  (let ((inputs (combine inputs minuend subtrahend))
        (outputs (if (null output) outputs (list output)))
        (successors (combine successors normal-successor overflow-successor)))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction SIGNED-LESS-INSTRUCTION

(defclass signed-less-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction signed-less-instruction) slot-names
     &rest keys
     &key
       inputs argument1 argument2
       outputs output
       successors true-successor false-successor)
  (assert (all-or-none argument1 argument2))
  (assert (all-or-none true-successor false-successor))
  (let ((inputs (combine inputs argument1 argument2))
        (outputs (if (null output) outputs (list output)))
        (successors (combine successors true-successor false-successor)))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction SIGNED-NOT-GREATER-INSTRUCTION

(defclass signed-not-greater-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction signed-not-greater-instruction) slot-names
     &rest keys
     &key
       inputs argument1 argument2
       outputs output
       successors true-successor false-successor)
  (assert (all-or-none argument1 argument2))
  (assert (all-or-none true-successor false-successor))
  (let ((inputs (combine inputs argument1 argument2))
        (outputs (if (null output) outputs (list output)))
        (successors (combine successors true-successor false-successor)))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction UNSIGNED-ADD-INSTRUCTION

(defclass unsigned-add-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction unsigned-add-instruction) slot-names
     &rest keys
     &key
       inputs augend addend
       outputs output
       successors normal-successor carry-successor)
  (assert (all-or-none augend addend))
  (assert (all-or-none normal-successor carry-successor))
  (let ((inputs (combine inputs augend addend))
        (outputs (if (null output) outputs (list output)))
        (successors (combine successors normal-successor carry-successor)))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction UNSIGNED-SUB-INSTRUCTION

(defclass unsigned-sub-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction unsigned-sub-instruction) slot-names
     &rest keys
     &key
       inputs minuend subtrahend
       outputs output
       successors normal-successor carry-successor)
  (assert (all-or-none minuend subtrahend))
  (assert (all-or-none normal-successor carry-successor))
  (let ((inputs (combine inputs minuend subtrahend))
        (outputs (if (null output) outputs (list output)))
        (successors (combine successors normal-successor carry-successor)))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction UNSIGNED-DIV-INSTRUCTION

(defclass unsigned-div-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction unsigned-div-instruction) slot-names
     &rest keys
     &key
       inputs dividend divisor
       outputs quotient remainder
       successors successor)
  (assert (all-or-none dividend divisor))
  (let ((inputs (combine inputs dividend divisor))
        (outputs (combine outputs quotient remainder))
        (successors (if (null successor) successors (list successor))))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction UNSIGNED-LESS-INSTRUCTION

(defclass unsigned-less-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction unsigned-less-instruction) slot-names
     &rest keys
     &key
       inputs argument1 argument2
       outputs output
       successors true-successor false-successor)
  (assert (all-or-none argument1 argument2))
  (assert (all-or-none true-successor false-successor))
  (let ((inputs (combine inputs argument1 argument2))
        (outputs (if (null output) outputs (list output)))
        (successors (combine successors true-successor false-successor)))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction UNSIGNED-NOT-GREATER-INSTRUCTION

(defclass unsigned-not-greater-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction unsigned-not-greater-instruction) slot-names
     &rest keys
     &key
       inputs argument1 argument2
       outputs output
       successors true-successor false-successor)
  (assert (all-or-none argument1 argument2))
  (assert (all-or-none true-successor false-successor))
  (let ((inputs (combine inputs argument1 argument2))
        (outputs (if (null output) outputs (list output)))
        (successors (combine successors true-successor false-successor)))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MIR instruction EQUAL-INSTRUCTION

(defclass equal-instruction (instruction multiple-successors-mixin)
  ())

(defmethod shared-initialize :around
    ((instruction equal-instruction) slot-names
     &rest keys
     &key
       inputs argument1 argument2
       outputs output
       successors true-successor false-successor)
  (assert (all-or-none argument1 argument2))
  (assert (all-or-none true-successor false-successor))
  (let ((inputs (combine inputs argument1 argument2))
        (outputs (if (null output) outputs (list output)))
        (successors (combine successors true-successor false-successor)))
    (apply #'call-next-method instruction slot-names
           :inputs inputs
           :outputs outputs
           :successors successors
           keys)))

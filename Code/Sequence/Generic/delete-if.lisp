(cl:in-package #:sicl-sequence)

(defmethod delete-if (test (list list) &key from-end (start 0) end count key)
  (with-predicate (predicate test)
    (with-key-function (key key)
      (delete-in-list
       (lambda (x) (predicate (key x)))
       list from-end start end count))))

(seal-domain #'delete-if '(t list))

(replicate-for-each-relevant-vectoroid #1=#:vectoroid
  (defmethod delete-if (test (vectoroid #1#) &key from-end (start 0) end count key)
    (with-predicate (predicate test)
      (with-key-function (key key)
        (delete-in-vector
         (lambda (x) (predicate (key x)))
         vectoroid from-end start end count)))))

(seal-domain #'delete-if '(t vector))

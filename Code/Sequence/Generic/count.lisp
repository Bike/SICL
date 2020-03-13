(cl:in-package #:sicl-sequence)

(defmethod count (item (list list) &key from-end (start 0) end key test test-not)
  (let ((count 0))
    (with-test-function (test test test-not)
      (with-key-function (key key)
        (for-each-relevant-cons (cons index list start end from-end)
          (when (test item (key (car cons)))
            (incf count)))))
    count))

(replicate-for-each-relevant-vectoroid #1=#:vectoroid
  (defmethod count (item (vectoroid #1#) &key from-end (start 0) end key test test-not)
    (let ((count 0))
      (with-test-function (test test test-not)
        (with-key-function (key key)
          (for-each-relevant-element (element index vectoroid start end from-end)
            (when (test item (key element))
              (incf count)))))
      count)))

(seal-domain #'count '(t sequence))

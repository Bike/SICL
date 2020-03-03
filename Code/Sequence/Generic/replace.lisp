(cl:in-package #:sicl-sequence)

(defmethod replace ((list1 list) (list2 list) &key (start1 0) end1 (start2 0) end2)
  (flet ((terminate (n)
           (declare (ignore n))
           (return-from replace list1)))
    (let ((dst (make-sequence-writer list1 start1 end1 nil #'terminate))
          (src (make-sequence-reader list2 start2 end2 nil #'terminate)))
      (loop (funcall dst (funcall src))))))

(replicate-for-each-relevant-vectoroid #1=#:vectoroid
  (defmethod replace ((list list) (vector #1#) &key (start1 0) end1 (start2 0) end2)
    (flet ((terminate (n)
             (declare (ignore n))
             (return-from replace list)))
      (let ((dst (make-sequence-writer list start1 end1 nil #'terminate))
            (src (make-sequence-reader vector start2 end2 nil #'terminate)))
        (loop (funcall dst (funcall src))))))

  (defmethod replace ((vector #1#) (list list) &key (start1 0) end1 (start2 0) end2)
    (flet ((terminate (n)
             (declare (ignore n))
             (return-from replace vector)))
      (let ((dst (make-sequence-writer vector start1 end1 nil #'terminate))
            (src (make-sequence-reader list start2 end2 nil #'terminate)))
        (loop (funcall dst (funcall src)))))))

(replicate-for-all-compatible-vectoroids #1=#:vectoroid-1 #2=#:vectoroid-2
  (defmethod replace ((vectoroid-1 #1#) (vectoroid-2 #2#) &key (start1 0) end1 (start2 0) end2)
    (flet ((terminate (n)
             (declare (ignore n))
             (return-from replace vectoroid-1)))
      (let ((dst (make-sequence-writer vectoroid-1 start1 end1 nil #'terminate))
            (src (make-sequence-reader vectoroid-2 start2 end2 nil #'terminate)))
        (loop (funcall dst (funcall src)))))))

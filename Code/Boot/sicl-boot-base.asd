(cl:in-package #:asdf-user)

(defsystem #:sicl-boot-base
  :depends-on (#:sicl-extrinsic-environment
               #:sicl-ast-to-hir
               #:sicl-hir-interpreter
               #:sicl-hir-to-mir
               #:sicl-mir-to-lir
               #:sicl-code-generation)
  :serial t
  :components
  ((:file "packages")
   (:file "environment")
   (:file "boot-class")
   (:file "client")
   (:file "utilities")))

(cl:in-package #:common-lisp-user)

(defpackage #:cleavir-environment
  (:nicknames #:cleavir-env)
  (:use #:common-lisp)
  (:shadow #:identity
	   #:type
	   #:ignore
	   #:dynamic-extent
	   #:compiler-macro
	   #:speed
	   #:safety
	   #:compilation-speed
	   #:space
	   #:debug
	   #:eval
	   #:macro-function
	   #:compiler-macro-function
	   #:function
	   #:block
	   #:inline
	   #:optimize)
  (:export
   #:variable-info
   #:lexical-variable-info
   #:special-variable-info
   #:constant-variable-info
   #:symbol-macro-info
   #:function-info
   #:local-function-info
   #:global-function-info
   #:local-macro-info
   #:global-macro-info
   #:special-operator-info
   #:block-info
   #:tag-info
   #:optimize-info
   #:optimize-qualities
   #:&rest-equivalents
   #:allowed-lambda-list-keywords
   #:global-environment
   #:name
   #:identity
   #:type
   #:ignore
   #:ast
   #:dynamic-extent
   #:value
   #:expansion
   #:expander
   #:compiler-macro
   #:speed
   #:safety
   #:compilation-speed
   #:space
   #:debug
   #:no-variable-info
   #:no-function-info
   #:no-block-info
   #:no-tag-info
   #:type-expand
   #:add-lexical-variable
   #:add-special-variable
   #:add-local-symbol-macro
   #:add-local-function
   #:add-local-macro
   #:add-block
   #:add-tag
   #:add-variable-type
   #:add-function-type
   #:add-variable-ignore
   #:add-function-ignore
   #:add-variable-dynamic-extent
   #:add-function-dynamic-extent
   #:add-optimize
   #:add-inline
   #:add-inline-expansion
   #:eval
   #:macro-function
   #:compiler-macro-function
   #:symbol-macro-expansion
   #:lexical-variable
   #:special-variable
   #:global-p
   #:symbol-macro
   #:function
   #:macro
   #:block
   #:tag
   #:variable-type
   #:function-type
   #:variable-ignore
   #:function-ignore
   #:variable-dynamic-extent
   #:function-dynamic-extent
   #:inline
   #:optimize))

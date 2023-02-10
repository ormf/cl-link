;;;; cl-link.lisp
;;
;;;; Copyright (c) 2023 Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de>


(in-package :cl-link)

(pushnew (pathname "/usr/local/lib/")
         cffi:*foreign-library-directories*
         :test #'equal)

(cffi:define-foreign-library clcxx
    (t (:default "libClCxx")))

(pushnew (asdf:system-relative-pathname :cl-link "link-clcxx/lib/")
         cffi:*foreign-library-directories*
         :test #'equal)

(cffi:define-foreign-library ableton-link
  (t (:default "libAbletonLink")))

(cffi:use-foreign-library clcxx)
(cffi:use-foreign-library ableton-link)

(cxx:init)

;;; (cxx:add-package "TEST" "TEST")

;; (cxx:add-package "LINK_CLCXX" "LINK_CLCXX")

;;;; cl-link.lisp
;;
;;;; Copyright (c) 2023 Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de>


(in-package :cl-link)

(pushnew (asdf:system-relative-pathname :cl-link "link-clcxx/lib/")
         cffi:*foreign-library-directories*
         :test #'equal)

(pushnew (pathname "/usr/local/lib/")
         cffi:*foreign-library-directories*
         :test #'equal)

(cffi:define-foreign-library clcxx
    (t (:default "libclcxx")))

(cffi:use-foreign-library clcxx)

(namestring (merge-pathnames "libAbletonLink" (asdf:system-relative-pathname :cl-link "link-clcxx/lib/")))

(cffi:define-foreign-library ableton-link
  (t (:default "/home/orm/work/programmieren/lisp/cl-link/link-clcxx/lib/libAbletonLink")))

(cffi:use-foreign-library ableton-link)

(cxx:init)

(cxx:add-package "LINK_CLCXX" "LINK_CLCXX")


;;; 
;;;(cxx:add-package "TEST" "TEST")

;;; (cxx:add-package "LINK_CLCXX" "LINK_CLCXX")



;;; (make-instance 'abl-link::link)



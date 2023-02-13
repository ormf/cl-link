;;; 
;;; test.lisp
;;;
;;; **********************************************************************
;;; Copyright (c) 2023 Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de>
;;;
;;; Revision history: See git repository.
;;;
;;; This program is free software; you can redistribute it and/or
;;; modify it under the terms of the Gnu Public License, version 2 or
;;; later. See https://www.gnu.org/licenses/gpl-2.0.html for the text
;;; of this agreement.
;;; 
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;; GNU General Public License for more details.
;;;
;;; **********************************************************************

(in-package :cl-link)

(shadowing-import
 '(link-clcxx:make-ableton-link) 'cl-link)

(export '(make-ableton-link) 'cl-link)




(defparameter *link* (make-AbletonLink 120.0d0))

(micros *link*)
(enable *link* t)
(enablestartstopsync *link* t)

(defparameter *s* (captureSessionState *link*))

(tempo *s*)

;;; creating an instance of xx:

(defparameter *test* (test:create-xx2 10 12))

;;; getter and setter for members of xx:

(test:y.get *test*)

(test:y.set *test* 10)

;;; submitting pointers of values to c-functions:

(let ((i (cffi:foreign-alloc :int :initial-element 3)))
  (test:ref-int i)
  (cffi:mem-aref i :int 0))


;;; calling a c function referencing the instance of a C-class:

(test:ref-class (slot-value *test* 'cxx::cxx-class-ptr))

;;; after calling it, the y slot is changed to 1000000:

(test:y.get *test*)

(test:foo.x *test*)


(test:test-int 40)


(test::xx)

(in-package :test)

(cl-user::defparameter *test* (cl-user::make-instance 'xx))

(cl-user::setf (cl-user::slot-value *test* 'y) 12)

(test::init)
(test::foo *test*)

(test:hi "Cxx")

(test:greet)

(make-instance 'test:xx)

#|
(test:greet)
(defparameter *test* (test:create-xx2 10 20))
(test:y.get *test*)
(test:y.set *test* 14)
(test:foo *test*)

(test:x.get *test*)
(test:x.set *test* 14)

(defparameter *test* (link_clcxx:create-link1 120.0d0))

(link_clcxx:tempo (link_clcxx:destruct-sessionstate *test*))

(link_clcxx:enable *test*)

(use-package :cl)
(test:greet)
(test:hi "Cxx")



*test*

|#

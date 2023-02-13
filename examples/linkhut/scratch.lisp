;;; 
;;; scratch.lisp
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

(change-tempo *link* 120)

(enable-link *link* t)
(enable-link *link* nil)
(start *link*)
(stop *link*)
(num-peers *link*)

;;; doesn't work (unhandled memory faults):

(cffi:defcallback tempo-callback :void
    ((tempo :double))
  (format t "tempo-callback: ~,2f" tempo))

(set-tempo-callback
 *link*
 (callback tempo-callback))

(cffi:defcallback num-peers-callback :void
    ((num-peers size_t))
  (format t "num-peers-callback: ~a" num-peers))

(set-num-peers-callback
 *link*
 (callback num-peers-callback))

(cffi:defcallback start-stop-callback :void
    ((playing-p :boolean))
  (format t "start-stop-callback: ~,2f" playing-p))

(set-start-stop-callback
 *link*
 (callback start-stop-callback))

;;; doesn't work (stack overflow):

(enable-start-stop-sync *link* t)
(enable-start-stop-sync *link* nil)

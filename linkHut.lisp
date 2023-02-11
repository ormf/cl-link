;;; 
;;; linkHut.lisp
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

(defparameter *link* (make-ableton-link 120.0d0))

(defsetf is-enabled (obj) (val)
  `(enable ,obj ,val))

(defsetf is-start-stop-sync-enabled (obj) (val)
  `(enable-start-stop-sync ,obj ,val))



(setf (is-enabled *link*) nil)
(setf (is-start-stop-sync-enabled *link*) t)



(micros *link*)

(defparameter *s* (capture-session-state *link*))

(tempo *s*)
(beat-at-time *s* (micros *link*) 0.0d0)
(is-playing *s*)
(phase-at-time *s* (micros *link*) 4d0)
(set-is-playing *s* t (micros *link*))

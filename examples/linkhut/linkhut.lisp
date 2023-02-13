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

;; (unless (find-package :cl-link) (ql:quickload "cl-link"))
;; (unless (find-package :websocket-server) (ql:quickload "websocket-server"))
;; (unless (find-package :clack) (ql:quickload "clack"))
;; (unless (find-package :websocket-driver) (ql:quickload "websocket-driver"))

(in-package :cl-link)

(setf *chat-handler* (clack:clackup #'websocket-server::chat-server :port 12345))

(defparameter *link* (make-ableton-link 120.0d0))

(defun print-state (time state link-enabled num-peers quantum start-stop-sync-on)
  (let ((phase (phase-at-time state time (float quantum 1.0d0))))
    (broadcast-message
     (format nil "~7a | ~9a | ~7a | ~3a | ~11a | ~,2f | ~,2f | ~7a |"
             (if link-enabled "yes" "no")
             num-peers
             (float quantum 1.0)
             (if start-stop-sync-on "yes" "no")
             (float (tempo state) 1.0)
             (beat-at-time state time quantum)
             (if (is-playing state) "[playing]" "[stopped]")
             (with-output-to-string (out)
               (dotimes (i (ceiling quantum))
                 (format out (if (< i phase) "X" "0"))))))))



(defsetf is-enabled (obj) (val)
  `(enable ,obj ,val))

(defsetf is-start-stop-sync-enabled (obj) (val)
  `(enable-start-stop-sync ,obj ,val))

(defun change-tempo (link tempo)
  (let ((state (capture-session-state link))
        (host-time (micros *link*)))
    (set-tempo state (float tempo 1.0d0) host-time)
    (commit-session-state link state)))

(defun start (link)
  (let ((state (capture-session-state link))
        (host-time (micros *link*)))
    (set-is-playing state t host-time)
    (commit-session-state link state)))

(defun stop (link)
  (let ((state (capture-session-state link))
        (host-time (micros *link*)))
    (set-is-playing state nil host-time)
    (commit-session-state link state)))

(defun enable-start-stop-sync (link val)
  (let ((state (capture-session-state link)))
    (enable-start-stop-sync link val)
    (commit-session-state link state)))

(defun enable-link (link val)
  (let ((state (capture-session-state link)))
    (enable link val)
    (commit-session-state link state)))

(defparameter *running* t)

#|
(loop
  while *running*
  do (progn
       (print-state (micros *link*) (capture-session-state *link*) t 0 4.0d0 t )
       (sleep 0.1)))
|#

(bt:make-thread
 (lambda ()
   (loop
     while *running*
     do (progn
          (print-state (micros *link*) (capture-session-state *link*) t 0 4.0d0 t )
          (sleep 0.1)))))

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

(unless (find-package :cl-link) (ql:quickload "cl-link"))
(unless (find-package :websocket-server) (ql:quickload "websocket-server"))
;; (unless (find-package :clack) (ql:quickload "clack"))
;; (unless (find-package :websocket-driver) (ql:quickload "websocket-driver"))

(in-package :cl-link)
(use-package :websocket-server)
(setf *chat-handler* (clack:clackup #'websocket-server::chat-server :port 12345))

(defparameter *link* (make-ableton-link 120.0d0))
(defparameter *running* t)

(defun print-state (time state link-enabled num-peers quantum start-stop-sync-on)
  (let ((phase (phase-at-time state time (float quantum 1.0d0))))
    (broadcast-message
     (format nil "~7a | ~9a | ~7,2f | ~3a | ~11a | ~7a | ~,2f | ~7a |~%"
             (if link-enabled "yes" "no")
             num-peers
             (beat-at-time state time quantum)
             (float quantum 1.0)
             (if start-stop-sync-on "yes" "no")
             (float (tempo state) 1.0)
             (if (is-playing state) "[playing]" "[stopped]")
             (with-output-to-string (out)
               (dotimes (i (ceiling quantum))
                 (format out (if (< i phase) "X" "0"))))))))

(loop
  while *running*
  do (progn
       (print-state (micros *link*) (capture-session-state *link*) t 0 4.0d0 t )
       (sleep 0.1)))

(defsetf is-enabled (obj) (val)
  `(enable ,obj ,val))

(defsetf is-start-stop-sync-enabled (obj) (val)
  `(enable-start-stop-sync ,obj ,val))



(enable-start-stop-sync *link* nil)

(num-peers *link*)

(setf (is-enabled *link*) nil)
(setf (is-start-stop-sync-enabled *link*) t)
#|
(defun get-metro (phase quantum)
  (with-output-to-string (out)
    (dotimes (i (ceiling quantum))
      (format out (if (< i phase) "X" "0")))))

;;; (get-metro 2 4)
|#



(defstruct state
  (running t)
  (link (make-ableton-link 120.0d0))
  )
(audio-platform *link*)

(start-playing)

(tempo (capture-session-state *link*))
(beat-at-time (capture-session-state *link*) (micros *link*) 0.0d0)
(is-playing (capture-session-state *link*))
(phase-at-time (capture-session-state *link*) (micros *link*) 4d0)
(set-is-playing (capture-session-state *link*) t (micros *link*))

(defun change-tempo (link tempo)
  (let ((state (capture-session-state link))
        (host-time (micros *link*)))
    (set-tempo state tempo host-time)
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

(enable-start-stop-sync *link* t)

(start *link*)

(stop *link*)

(change-tempo *link* 90.0d0)

(micros *link*)

(ql:quickload "ltk")
(in-package :ltk-user)

(defparameter *text-box* nil)
(defparameter *canvas* nil)

(ltk::main-loop)

(ltk:with-ltk ()
  (let ((c (make-instance 'ltk:canvas :width 500 :height 500)))
    (ltk:pack c)
    (let ((txt (ltk:create-text c 200 100 "lorem ipsum dolor sit amet consectetur adipiscing elit"))))))

(ltk:itemconfigure *canvas* 1 :text "Hallo Peng")
(ltk:format-wish)
(ltk:send-wish)

*wish*

(defun main ()
  (ltk:with-ltk ()
    (let ((c (make-instance 'ltk:canvas :width 500 :height 500)))
      (ltk:pack c)
      (let ((txt (ltk:create-text c 100 100 "lorem ipsum dolor sit amet consectetur adipiscing elit")))
        (ltk:itemconfigure c txt :width 100)
        (ltk:itemconfigure c txt :font "FreeMono")
        (ltk:itemconfigure c txt :justify "center"))))) 

(with-ltk ()
  (let ((button (make-instance 'text :text "Hello World")))
    (grid button 0 0)))

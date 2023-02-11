;;; 
;;; export-syms.lisp
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

;;; here we export the symbols of link-clcxx. We can't do that in
;;; package.lisp as the symbols haven't yet been imported when the
;;; package gets defined.

(export '(micros
          tempo
          set-tempo
          beat-at-time
          phase-at-time
          time-at-beat
          request-beat-at-time
          is-playing
          set-is-playing
          is-enabled
          enable
          num-peers
          micros
          capture-session-state
          commit-session-state
          is-start-stop-sync-enabled
          enable-start-stop-sync
          set-num-peers-callback
          set-tempo-callback
          set-start-stop-callback
          make-ableton-link)
        'cl-link)

;;;; linkHut.asd
;;
;;;; Copyright (c) 2023 Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de>

(asdf:defsystem #:linkhut
  :description "linkHut example"
  :author "Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de>"
  :license  "gpl 2.0 or later"
  :version "0.0.1"
  :serial t
  :depends-on (:cl-link :bordeaux-threads :websocket-server)
  :components ((:file "package")
               (:file "linkhut")))

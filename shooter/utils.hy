(import config)

(setv INFO "[INFO] ")
(setv DEBUG "[DEBUG] ")

(defn log [^str text &optional [debug False]]
    (if
        (= debug False) (print (+ INFO text))
        (print (+ DEBUG text))))
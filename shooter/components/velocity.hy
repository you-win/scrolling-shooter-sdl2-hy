(defclass Velocity [] 
    (defn --init-- [self &optional [x 0.0] [y 0.0]] 
        (setv (. self x) x (. self y) y)))
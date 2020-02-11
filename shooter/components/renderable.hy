(defclass Renderable [] 
    (defn --init-- [self texture width height pos-x pos-y] 
        (setv (. self texture) texture)
        (setv (. self w) width (. self h) height)
        (setv (. self x) pos-x (. self y) pos-y)))
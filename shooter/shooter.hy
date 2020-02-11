(import [sdl2 [*]]
    [sdl2.ext :as ext]
    esper
    [components [Velocity Renderable]]
    [processors [RenderProcessor MovementProcessor]]
    config
    [utils [log]])

(require [macros [*]]
    [hy.extra.anaphoric [ap-each]])

(defn texture-from-image [renderer image-name]
    (setv soft-surface (.load-image ext image-name))
    (setv texture (SDL-CreateTextureFromSurface (. renderer renderer) soft-surface))
    (SDL-FreeSurface soft-surface)
    texture)

(defn run []
    ;; Initialize PySDL2 stuff
    (.init ext)
    (setv window ((. ext Window) :title "Esper PySDL2 example" :size (. config RESOLUTION)))
    (setv renderer ((. ext Renderer) :target window))
    (.show window)

    ;; Initialize esper world
    (setv world (.World esper))
    (setv player (.create-entity world))
    (.add-component world player (Velocity :x 0 :y 0))
    (.add-component world player (Renderable :texture (texture-from-image renderer "assets/blue-square.png")
                                            :width 32 :height 32 :pos-x 100 :pos-y 100))
    (setv enemy (.create-entity world))
    (.add-component world enemy (Renderable :texture (texture-from-image renderer "assets/red-square.png")
                                            :width 32 :height 32 :pos-x 400 :pos-y 250))
    (setv render-processor (RenderProcessor :renderer renderer))
    (setv movement-processor (MovementProcessor :min-x 0 :max-x (get (. config RESOLUTION) 0) :min-y 0 :max-y (get (. config RESOLUTION) 1)))
    (.add-processor world render-processor)
    (.add-processor world movement-processor)
    
    ;; Main loop
    (setv running True)
    
    (while (= running True)
        (setv start-time (SDL-GetTicks))
        
        (ap-each (.get-events ext)
            (setv type (. it type))
            (if (= type SDL-QUIT) (do (setv running False) (break))
                (= type SDL-KEYDOWN)
                    (do 
                        (setv key (get-value (. config CONTROLS) (. it key keysym sym) (. config NOT-REGISTERED)))
                        (log key (. config DEBUG))
                        (if (= key (. config MOVE-UP))
                            (setv (. (.component-for-entity world player Velocity) y) -3))
                        (if (= key (. config MOVE-DOWN))
                            (setv (. (.component-for-entity world player Velocity) y) 3))
                        (if (= key (. config MOVE-LEFT))
                            (setv (. (.component-for-entity world player Velocity) x) -3))
                        (if (= key (. config MOVE-RIGHT))
                            (setv (. (.component-for-entity world player Velocity) x) 3))
                        (if (= key (. config CANCEL))
                            (do (setv running False) (break))))
                (= type SDL-KEYUP)
                    (do 
                        (setv key (get-value (. config CONTROLS) (. it key keysym sym) (. config NOT-REGISTERED)))
                        (if (in key [(. config MOVE-UP) (. config MOVE-DOWN)])
                            (setv (. (.component-for-entity world player Velocity) y) 0))
                        (if (in key [(. config MOVE-LEFT) (. config MOVE-RIGHT)])
                            (setv (. (.component-for-entity world player Velocity) x) 0)))))
        
        (.process world)
        
        (setv current-time (SDL-GetTicks))
        (setv sleep-time (int (- (+ start-time 16.667) current-time)))
        (if (> sleep-time 0) (SDL-Delay sleep-time))))

(if (is __name__ "__main__")
    (run)
    (.quit ext))

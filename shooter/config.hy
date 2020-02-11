(import [sdl2 [SDLK-UP SDLK-DOWN SDLK-LEFT SDLK-RIGHT SDLK-w SDLK-s
                SDLK-a SDLK-d SDLK-RETURN SDLK-ESCAPE]])

(setv DEBUG True)

(setv SCREEN-WIDTH 1600)
(setv SCREEN-HEIGHT 900)
(setv RESOLUTION (, SCREEN-WIDTH SCREEN-HEIGHT))

(setv MOVE-LEFT "move-left")
(setv MOVE-RIGHT "move-right")
(setv MOVE-UP "move-up")
(setv MOVE-DOWN "move-down")
(setv ACCEPT "accept")
(setv CANCEL "cancel")

(setv NOT-REGISTERED "not-registered")

(setv CONTROLS {
    SDLK-UP MOVE-UP
    SDLK-DOWN MOVE-DOWN
    SDLK-LEFT MOVE-LEFT
    SDLK-RIGHT MOVE-RIGHT
    SDLK-w MOVE-UP
    SDLK-s MOVE-DOWN
    SDLK-a MOVE-LEFT
    SDLK-d MOVE-RIGHT
    SDLK-RETURN ACCEPT
    SDLK-ESCAPE CANCEL})
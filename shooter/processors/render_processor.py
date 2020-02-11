from sdl2 import *
import esper
from components import Renderable


class RenderProcessor(esper.Processor):
    def __init__(self, renderer, clear_color=(0, 0, 0)):
        super().__init__()
        self.renderer = renderer
        self.clear_color = clear_color

    def process(self):
        self.renderer.clear(self.clear_color)
        destination = SDL_Rect(0, 0, 0, 0)
        for ent, rend in self.world.get_component(Renderable):
            destination.x = int(rend.x)
            destination.y = int(rend.y)
            destination.w = rend.w
            destination.h = rend.h
            SDL_RenderCopy(self.renderer.renderer,
                           rend.texture, None, destination)
        self.renderer.present()

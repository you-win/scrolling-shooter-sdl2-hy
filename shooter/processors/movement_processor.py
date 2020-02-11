import esper
from components import Velocity, Renderable


class MovementProcessor(esper.Processor):
    def __init__(self, min_x, max_x, min_y, max_y):
        super().__init__()
        self.min_x, self.max_x = min_x, max_x
        self.min_y, self.max_y = min_y, max_y

    def process(self):
        for ent, (vel, rend) in self.world.get_components(Velocity, Renderable):
            rend.x += vel.x
            rend.y += vel.y

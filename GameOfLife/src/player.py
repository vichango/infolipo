import numpy as np

class Player:
    def __init__(self, color=(128, 0, 128)):
        """
        Initialize a player.
        """

        self.color = color
        self.bg_color = np.average(np.array([self.color, (0, 0, 0), (0, 0, 0)]), axis=0)

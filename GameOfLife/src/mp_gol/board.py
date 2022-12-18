import random
import copy

class Board:
    def __init__(self, players: tuple, columns=64, rows=48):
        """
        Initialize the game, and sets defaults setting.
        """

        self.columns = columns
        self.rows = rows
        self.players = players
        self.history_grid = [[(0, 0, 0) for i in range(self.columns)] for j in range(self.rows)]
        self.current_grid = [[[0 for p in range(len(self.players))] for i in range(self.columns)] for j in range(self.rows)]

        self.randomize_grid()

    def randomize_grid(self):
        for r in range(self.rows):
            for c in range(self.columns):
                for p in range(len(self.players)):
                    if (random.randint(0, 9) == 0):
                        self.current_grid[r][c][p] = 1
                    else:
                        self.current_grid[r][c][p] = 0

    def update_grids(self):
        """
        Apply the rules on all grids.
        """

        # Helper tables for continuous edges.
        dx = [-1, -1, -1, 0, 0, 1, 1, 1]
        dy = [-1, 0, 1, -1, 1, -1, 0, 1]

        # Create a copy by value.
        tmp_grid = copy.deepcopy(self.current_grid)

        for r in range(self.rows):
            for c in range(self.columns):
                for p in range(len(self.players)):
                    alive = 0

                    # Count how many alive/dead.
                    for i in range(8):
                        near_column = (c + dy[i]) % self.columns
                        near_row = (r + dx[i]) % self.rows

                        if self.current_grid[near_row][near_column][p]:
                            alive += 1

                    # Apply alive cell rules
                    if self.current_grid[r][c][p]:
                        if alive == 2 or alive == 3:
                            tmp_grid[r][c][p] = 1
                        else:
                            tmp_grid[r][c][p] = 0

                    # Apply dead Cell rules
                    else:
                        if alive == 3:
                            tmp_grid[r][c][p] = 1
                        else:
                            tmp_grid[r][c][p] = 0

        # Copy new state by value.
        self.current_grid = copy.deepcopy(tmp_grid)


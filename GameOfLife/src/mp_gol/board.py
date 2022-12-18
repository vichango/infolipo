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
        self.history_grid = [[-1 for i in range(self.columns)] for j in range(self.rows)]
        self.grids = []

        for i in range(len(players)):
            self.grids.append([[0 for i in range(self.columns)] for j in range(self.rows)])

        self.randomize_grids()

    def randomize_grids(self):
        for grid in self.grids:
            for r in range(self.rows):
                for c in range(self.columns):
                    grid[r][c] = random.randint(0, 9) == 9

    def update_grids(self):
        """
        Apply the rules on all grids.
        """

        # Helper tables for continuous edges.
        dx = [-1, -1, -1, 0, 0, 1, 1, 1]
        dy = [-1, 0, 1, -1, 1, -1, 0, 1]

        for g in range(len(self.grids)):
            grid = self.grids[g]

            # Create a copy by value.
            tmp_grid = copy.deepcopy(grid)

            for r in range(self.rows):
                for c in range(self.columns):
                    life = 0

                    # Count how many alive/dead.
                    for i in range(8):
                        nc = (c + dy[i]) % self.columns
                        nr = (r + dx[i]) % self.rows

                        if grid[nr][nc]:
                            life += 1

                    # Apply life cell rules
                    if grid[r][c]:
                        if life == 2 or life == 3:
                            tmp_grid[r][c] = 1
                        else:
                            tmp_grid[r][c] = 0

                    # Apply dead Cell rules
                    else:
                        if life == 3:
                            tmp_grid[r][c] = 1
                        else:
                            tmp_grid[r][c] = 0

            # Copy new state by value.
            self.grids[g] = copy.deepcopy(tmp_grid)


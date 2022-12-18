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
        self.neighbor_grid = [[[0 for p in range(len(self.players))] for i in range(self.columns)] for j in range(self.rows)]
        self.current_grid = [[[0 for p in range(len(self.players))] for i in range(self.columns)] for j in range(self.rows)]

    def randomize_grid(self):
        """
        Inputs random alive cells.
        """

        for r in range(self.rows):
            for c in range(self.columns):
                for p in range(len(self.players)):
                    if (random.randint(0, 9) == 0):
                        self.current_grid[r][c][p] = 1

    def update_neighbors(self):
        """
        Update the neighbors count.
        """

        # Helper tables for continuous edges.
        dx = [-1, -1, -1, 0, 0, 1, 1, 1]
        dy = [-1, 0, 1, -1, 1, -1, 0, 1]

        # Count how many alive neighbors.
        for r in range(self.rows):
            for c in range(self.columns):
                for p in range(len(self.players)):
                    alive = 0

                    for i in range(8):
                        nc = (c + dy[i]) % self.columns
                        nr = (r + dx[i]) % self.rows

                        if self.current_grid[nr][nc][p]:
                            alive += 1

                    self.neighbor_grid[r][c][p] = alive

    def update_conflicting(self):
        """
        Resolve status in cells with conflicts and set history value.
        """

        # Count how many alive neighbors.
        for r in range(self.rows):
            for c in range(self.columns):
                nc = [0 for p in range(len(self.players))]

                for p in range(len(self.players)):
                    if self.current_grid[r][c][p]:
                        nc[p] = self.neighbor_grid[r][c][p]

                if len(self.players) > nc.count(0):
                    max_nc = max(nc)
                    max_nc_c = nc.count(max_nc)

                    if 1 == max_nc_c:
                        pim = nc.index(max_nc)

                        for p in range(len(self.players)):
                            if pim == p:
                                self.current_grid[r][c][p] = 1
                                self.history_grid[r][c] = p
                            else:
                                self.current_grid[r][c][p] = 0
                    else:
                        self.history_grid[r][c] = -1

                        for p in range(len(self.players)):
                            if max_nc == nc[p]:
                                self.current_grid[r][c][p] = 1
                            else:
                                self.current_grid[r][c][p] = 0

    def update_grids(self):
        """
        Apply the rules on all grids.
        """

        self.update_neighbors()
        self.update_conflicting()

        # Apply usual rules on a temporary copy.
        tmp_grid = copy.deepcopy(self.current_grid)

        for r in range(self.rows):
            for c in range(self.columns):
                for p in range(len(self.players)):
                    # Apply alive cell rules
                    alive = self.neighbor_grid[r][c][p]

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

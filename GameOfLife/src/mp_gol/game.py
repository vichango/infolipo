import sys
import pygame

from board import Board

class Game:
    def __init__(self, board: Board, cell_size=10, max_fps=10):
        """
        Initialize the game, and sets defaults setting
        """

        self.board = board
        self.cell_size = cell_size
        self.max_fps = max_fps

        # Initialize dimensions from board.
        self.screen_width = self.board.columns * self.cell_size
        self.screen_height = self.board.rows * self.cell_size

        pygame.init()
        self.screen = pygame.display.set_mode((self.screen_width, self. screen_height))

        self.last_time_updated = 0
        self.paused = False
        pygame.display.flip()

        self.clear_screen()
        self.draw_grid()

    def clear_screen(self):
        """
        Basically clears the screen
        """
        self.screen.fill((0, 0, 0))

    def draw_grid(self):
        """
        Draws the board grids.
        """

        self.clear_screen()

        for i in range(len(self.board.grids)):
            grid = self.board.grids[i]

            for r in range(self.board.rows):
                for c in range(self.board.columns):
                    if grid[r][c]:
                        alive_color = self.board.players[i].color
                        pygame.draw.circle(
                            self.screen,
                            alive_color,
                            (c * self.cell_size + self.cell_size / 2,
                            r * self.cell_size + self.cell_size / 2), self.cell_size / 2, 0
                        )

        pygame.display.flip()

    def handle_events(self):
        """
        Handle quit signal and keypressed events.

        - 'p' to toggle pause.
        - 'r' to randomize all grids.
        - 'q' to quit.
        """

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                self.clear_screen()
                sys.exit()
            elif event.type == pygame.KEYDOWN and event.unicode == 'p':
                if self.paused:
                    self.paused = False
                else:
                    self.paused = True

        if pygame.key.get_pressed()[pygame.K_q]:
            self.clear_screen()
            sys.exit()
        elif pygame.key.get_pressed()[pygame.K_r]:
            self.board.randomize_grids()

    def run(self):
        """
        Main loop.
        """

        pygame.display.flip()
        while True:
            self.handle_events()

            if self.paused:
                continue

            self.board.update_grids()
            self.draw_grid()
            self.cap_frame_rate()

    def cap_frame_rate(self):
        """
        Adjust the screen refresh rate according to the max_fps.
        """

        desired_wait_time = (1.0 / self.max_fps) * 1000
        now = pygame.time.get_ticks()
        time_since_last_update = now - self.last_time_updated

        # Ensure that we wait desired_wait_time before the screen is updated again.
        time_to_wait = int(desired_wait_time - time_since_last_update)
        if time_to_wait > 0:
            pygame.time.delay(time_to_wait)

        self.last_time_updated = now

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
        Fill screen with black.
        """
        self.screen.fill((0, 0, 0))

    def draw_history(self, r, c, color):
        """
        Set the cell's background colors.
        """

        pygame.draw.rect(
            self.screen,
            color,
            pygame.Rect(
                c * self.cell_size,
                r * self.cell_size,
                self.cell_size,
                self.cell_size,
            )
        )

    def draw_cell(self, r, c, colors):
        """
        Draw a cell.
        """

        if 0 < len(colors):
            center = pygame.math.Vector2(
                c * self.cell_size + self.cell_size / 2,
                r * self.cell_size + self.cell_size / 2
            )

            # Conflict color.
            color = (0, 0, 0)
            radius = self.cell_size / 4

            if 1 == len(colors):
                color = colors[0]
                radius = self.cell_size / 3

            pygame.draw.circle(
                self.screen,
                color,
                center,
                radius,
                0
            )

    def draw_grid(self):
        """
        Draws the board.
        """

        self.clear_screen()

        for r in range(self.board.rows):
            for c in range(self.board.columns):
                hp = self.board.history_grid[r][c]
                if -1 < hp:
                    self.draw_history(r, c, self.board.players[hp].bg_color)

                colors = []
                for p in range(len(self.board.players)):
                    if self.board.current_grid[r][c][p]:
                        colors.append(self.board.players[p].color)

                self.draw_cell(r, c, colors)

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
            self.board.randomize_grid()

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

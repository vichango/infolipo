# README

A multi-player version of the Game-of-life cellular automaton.

At every iteration:

1. We count, for each player, the number of alive neighbors around each cell.
2. We try to solve conflicting cells by looking at which has the maximum number of neighbors. Only the cells with the maximum number of neighbohrs is kept alive.
3. We apply Conway's ruleset independently for each player.

We currently defines 3 players: Cyan, Magenta and Yellow.

1. Press `R` to bring random cells alive (`10%`).
2. Press `P` to pause the game.
3. Press `Q` to quit the game.

## Multi-player cell coloring

1. Average color:
    ```python
    import numpy as np

    color = np.average(np.array(colors), axis=0)
        pygame.draw.circle(
            self.screen,
            color,
            (c * self.cell_size + self.cell_size / 2,
            r * self.cell_size + self.cell_size / 2), self.cell_size / 2, 0
        )
    ```
2. Partial arc per palyer:
    ```python
    arc = 2 * math.pi / len(colors)
        arc_at = 0

        for color in colors:
            pygame.draw.arc(
                self.screen,
                color,
                pygame.Rect(
                    c * self.cell_size + self.cell_size / 2,
                    r * self.cell_size + self.cell_size / 2,
                    self.cell_size,
                    self.cell_size
                ),
                arc_at,
                arc_at + arc
            )
    ```

## References

- Another implementation in Python ([here](https://github.com/BodaSadalla98/Cookbook/tree/main/python))
    - Also some examples of Apps implemented using [Kivy](https://kivy.org/).
- An implemetation using pygame ([here](https://www.pygame.org/project/5560/))

Not explored:

- An implementation using Kivy ([here](https://github.com/SinOverCos/Kivy-Python---Game-of-Life))
- `game-of-life-python` topic in GitHub ([here](https://github.com/topics/game-of-life-python))
- A two player game using pygame ([here](https://github.com/JosephLGibson/Game-of-Game-of-Life))

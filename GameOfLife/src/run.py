from game import Game
from board import Board
from player import Player

if __name__ == '__main__':
    """
    Call module and run.
    """

    player_1 = Player((0, 255, 255))
    player_2 = Player((255, 0, 255))
    player_3 = Player((255, 255, 0))

    board = Board((player_1, player_2, player_3))

    game = Game(board)
    game.run()

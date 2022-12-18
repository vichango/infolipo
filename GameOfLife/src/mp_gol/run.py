from game import Game
from board import Board
from player import Player

if __name__ == '__main__':
    """
    Call module and run.
    """

    player_1 = Player((128, 0, 128))
    player_2 = Player((0, 128, 128))

    board = Board((player_1, player_2))

    game = Game(board)
    game.run()

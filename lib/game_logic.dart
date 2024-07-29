class Game {
  int size;
  List<List<String?>> board;
  String currentPlayer;

  Game(this.size)
      : board = List.generate(size, (_) => List.filled(size, null)),
        currentPlayer = 'X';

  bool makeMove(int row, int col) {
    if (board[row][col] != null) return false;
    board[row][col] = currentPlayer;
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    return true;
  }

  String? checkWinner() {
    for (int i = 0; i < size; i++) {
      if (board[i].every((cell) => cell == board[i][0] && cell != null)) {
        return board[i][0];
      }
      if (board.every((row) => row[i] == board[0][i] && row[i] != null)) {
        return board[0][i];
      }
    }
    if (board.every((row) => row[board.indexOf(row)] == board[0][0] && row[board.indexOf(row)] != null)) {
      return board[0][0];
    }
    if (board.every((row) => row[size - 1 - board.indexOf(row)] == board[0][size - 1] && row[size - 1 - board.indexOf(row)] != null)) {
      return board[0][size - 1];
    }
    if (board.every((row) => row.every((cell) => cell != null))) {
      return 'Draw';
    }
    return null;
  }
}

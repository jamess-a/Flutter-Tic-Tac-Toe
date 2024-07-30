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
        return board[i][0];//return the player who won
      }
      if (board.every((row) => row[i] == board[0][i] && row[i] != null)) {
        return board[0][i];// return the player who won
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

/*
bool makeMove(int row, int col) {
  if (board[row][col] != null) return false;
  board[row][col] = currentPlayer;
  currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  return true;
}
ฟังก์ชันนี้จะใช้สำหรับการเดินหมากในกระดาน
รับพารามิเตอร์ row และ col เพื่อระบุช่องในกระดานที่ต้องการเดินหมาก
ถ้าช่องนั้นไม่ว่าง (null) จะคืนค่า false และไม่ทำการเปลี่ยนแปลงใด ๆ
ถ้าช่องว่าง (null) จะวางหมากของผู้เล่นปัจจุบันในช่องนั้น และเปลี่ยนผู้เล่นปัจจุบัน (จาก 'X' เป็น 'O' หรือจาก 'O' เป็น 'X')
คืนค่า true เพื่อบอกว่าการเดินหมากสำเร็จ

checkwinner 

Row
วนลูปทุกแถว (for (int i = 0; i < size; i++) และใช้ .every เพื่อตรวจสอบว่าทุกช่องในแถวนั้นมีค่าเหมือนกัน (cell == board[i][0]) และไม่เป็น null
ถ้าเงื่อนไขนี้เป็นจริง จะคืนค่าผู้เล่นที่ชนะในแถวนั้น (return board[i][0])

Column
วนลูปทุกคอลัมน์ (for (int i = 0; i < size; i++) และใช้ .every เพื่อตรวจสอบว่าทุกแถวมีค่าของช่องในคอลัมน์นั้นเหมือนกัน (row[i] == board[0][i]) และไม่เป็น null
ถ้าเงื่อนไขนี้เป็นจริง จะคืนค่าผู้เล่นที่ชนะในคอลัมน์นั้น (return board[0][i])

Diagonals การตรวจสอบแนวทแยง
ใช้ .every เพื่อตรวจสอบว่าแนวทแยงหลัก (บนซ้ายไปล่างขวา) มีค่าเหมือนกัน (row[board.indexOf(row)] == board[0][0]) และไม่เป็น null
ใช้ .every เพื่อตรวจสอบว่าแนวทแยงรอง (บนขวาไปล่างซ้าย) มีค่าเหมือนกัน (row[size - 1 - board.indexOf(row)] == board[0][size - 1]) และไม่เป็น null
ถ้าเงื่อนไขใดเงื่อนไขหนึ่งเป็นจริง จะคืนค่าผู้เล่นที่ชนะในแนวทแยงนั้น (return board[0][0] หรือ return board[0][size - 1])

Full Table
ใช้ .every เพื่อตรวจสอบว่าทุกช่องในกระดานไม่เป็น null (แสดงว่ากระดานเต็ม)
ถ้ากระดานเต็ม จะคืนค่า 'Draw'
*/
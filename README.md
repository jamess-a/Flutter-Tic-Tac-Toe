# tic_tac_toe

Tic_Tac_TOE project.

##Requirement

Mobile emulator for running the Tic Tac Toe application:  
[Android Studio](https://developer.android.com/studio?hl=th)
[Flutter](https://docs.flutter.dev/get-started/install/windows/mobile)
[Dart]

### Dependencies

Ensure the following dependencies are added to your `pubspec.yaml` file:
if not add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.0.0+4
  path: ^1.8.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## Features

- Play Tic Tac Toe
- Save and retrieve game data using SQLite

## Installation Steps

1. Clone the repository:
    ```sh
    git clone https://github.com/jamess-a/tic_tac_toe.git
    cd tic_tac_toe
    ```
   Alternatively, you can download the zip file and extract it.

2. Fetch the dependencies:
    ```sh
    flutter pub get
    ```

Feel free to modify any sections according to your project's specifics and preferences!
By Pattanasin pluksek CPE



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

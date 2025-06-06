# Pattanasin pluksek CPE

## Game Logic
- การอธิบาย logic ของเกมเป็นภาษาไทย สามารถดูได้ที่ `lib -> game_logic.dart`

Tic_Tac_Toe project.

### Design front-end 
ในการ ออกเเบบหน้าเเอปพลิเคชั่นจะให้เหมือนกับเล่นเกมโทรศัพท์ เปิดเเล้วสามารถเริ่มเล่นได้เลยเเละไม่ซับซ้อน 
- main.dart จะเป็น หน้าหลักมี กระดานกับ ปุ่มเรียก history
- match_history.dart จะเป็น list ของ history ที่เรียกจาก database
- replay_match จะเป็นการ Read กระดานกับรายละเอียดต่างๆมา


โดยจะจัดให้ board ที่เป็นกระดานหลักอยู่กลางๆ เเละมี ปุ่ม restart เพื่อ clear board

### Design back-end 
- จะเป็น Localdatabase sqlite 
ในส่วนของหลังบ้านอยากจะทำให้เรียบง่ายไม่ติด Normalization ทำให้มีเพียง 1 table คือ matches1.db -> matches 
โดยใช้ คำสั่ง sql 
```yaml
CREATE TABLE matches (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            size INTEGER,
            board TEXT,
            winner TEXT,
            times timestamp default current_timestamp
          )
```
- เก็บ size ของ board ที่ผู้ใช้เลือก
- เก็บ board ที่ผู้ใช้ได้เล่น ตัวอย่าง json
```yaml
{
  "size": 3,
  "board": "[[\"X\",\"O\",\"X\"],[\"O\",\"X\",null],[null,\"O\",\"X\"]]",
  "winner": "X",
  "times": "2024-07-29T12:34:56.789Z"
}
```          
  
- เก็บ winner ที่ได้จาก game_logic 
- เก็บ times ที่ได้จาก timestamp 

โดยจะมีการเขียน Read , Create เเละ Delete


-Create sql 
```yaml
Future<void> insertMatch(Game game, String winner) async {
    final db = await database;
    await db.insert(
      'matches',
      {
        'size': game.size,
        'board': jsonEncode(game.board),
        'winner': winner,
        'times': DateTime.now().toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
```
-Delete sql 
```yaml
Future<void> deleteAllMatches() async {
    final db = await database;
    await db.delete('matches'); 
  }
```
-Read sql
```yaml
Future<List<Map<String, dynamic>>> getMatches() async {
    final db = await database;
    return await db.query('matches');
  }
```

### Prototype
![xo](https://github.com/user-attachments/assets/a0a6e9ad-458f-4906-8aaf-a8609a167810)

### Requirement

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

## Game Logic

### `bool makeMove(int row, int col)`

This function handles making a move on the game board:

- **Parameters**:
  - `row`: The row index where the move is made
  - `col`: The column index where the move is made

- **Behavior**:
  - **Check if Cell is Occupied**:
    - If the cell at `board[row][col]` is not `null`, the function returns `false` and does nothing.
  - **Make the Move**:
    - If the cell is `null`, place the current player's marker (`currentPlayer`) in that cell.
    - Switch the current player from 'X' to 'O' or from 'O' to 'X'.
    - Return `true` to indicate that the move was successfully made.

### `String? checkWinner()`

This function checks if there is a winner or if the game is a draw:

- **Row Check**:
  - Loop through each row with `for (int i = 0; i < size; i++)`.
  - Use `.every` to verify if all cells in the row are equal to `board[i][0]` and none of them are `null`.
  - If the condition is true, return the player who won in that row (`return board[i][0]`).

- **Column Check**:
  - Loop through each column with `for (int i = 0; i < size; i++)`.
  - Use `.every` to verify if all cells in the column are equal to `board[0][i]` and none of them are `null`.
  - If the condition is true, return the player who won in that column (`return board[0][i]`).

- **Diagonal Check**:
  - **Primary Diagonal (Top-Left to Bottom-Right)**:
    - Use `.every` to verify if all cells in the primary diagonal are equal to `board[0][0]` and none of them are `null`.
    - If the condition is true, return the player who won in the primary diagonal (`return board[0][0]`).
  - **Secondary Diagonal (Top-Right to Bottom-Left)**:
    - Use `.every` to verify if all cells in the secondary diagonal are equal to `board[0][size - 1]` and none of them are `null`.
    - If the condition is true, return the player who won in the secondary diagonal (`return board[0][size - 1]`).

- **Full Board Check**:
  - Use `.every` to check if all cells in the board are not `null` (indicating the board is full).
  - If the board is full and there is no winner, return `'Draw'`.


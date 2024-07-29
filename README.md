# tic_tac_toe 
# Pattanasin pluksek CPE
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

Game Logic 

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


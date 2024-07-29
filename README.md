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


Game Logic
makeMove(int row, int col)
ฟังก์ชันนี้ใช้สำหรับการเดินหมากในกระดาน:

parameter:

row: แถวที่ต้องการเดินหมาก
col: คอลัมน์ที่ต้องการเดินหมาก
การทำงาน:

ตรวจสอบว่าช่องที่ระบุ (board[row][col]) ไม่ว่าง (ไม่เป็น null)
ถ้าช่องนั้นไม่ว่าง: คืนค่า false และไม่ทำการเปลี่ยนแปลงใด ๆ
ถ้าช่องว่าง (null):
วางหมากของผู้เล่นปัจจุบันในช่องนั้น
เปลี่ยนผู้เล่นปัจจุบัน (จาก 'X' เป็น 'O' หรือจาก 'O' เป็น 'X')
คืนค่า true เพื่อบอกว่าการเดินหมากสำเร็จ
checkWinner()
ฟังก์ชันนี้ใช้เพื่อตรวจสอบผู้ชนะของเกม:

การตรวจสอบแถว (Rows)
การทำงาน:
วนลูปผ่านทุกแถว (for (int i = 0; i < size; i++))
ใช้ .every เพื่อตรวจสอบว่า:
ทุกช่องในแถวนั้นมีค่าเหมือนกัน (cell == board[i][0])
ทุกช่องไม่เป็น null
ถ้าเงื่อนไขนี้เป็นจริง: คืนค่าผู้เล่นที่ชนะในแถวนั้น (return board[i][0])
การตรวจสอบคอลัมน์ (Columns)
การทำงาน:
วนลูปผ่านทุกคอลัมน์ (for (int i = 0; i < size; i++))
ใช้ .every เพื่อตรวจสอบว่า:
ทุกแถวมีค่าของช่องในคอลัมน์นั้นเหมือนกัน (row[i] == board[0][i])
ทุกช่องไม่เป็น null
ถ้าเงื่อนไขนี้เป็นจริง: คืนค่าผู้เล่นที่ชนะในคอลัมน์นั้น (return board[0][i])
การตรวจสอบแนวทแยง (Diagonals)
การทำงาน:
แนวทแยงหลัก (จากบนซ้ายไปล่างขวา):
ใช้ .every เพื่อตรวจสอบว่า:
ทุกช่องในแนวทแยงหลักมีค่าเหมือนกัน (row[board.indexOf(row)] == board[0][0])
ทุกช่องไม่เป็น null
ถ้าเงื่อนไขนี้เป็นจริง: คืนค่าผู้เล่นที่ชนะในแนวทแยงหลัก (return board[0][0])
แนวทแยงรอง (จากบนขวาไปล่างซ้าย):
ใช้ .every เพื่อตรวจสอบว่า:
ทุกช่องในแนวทแยงรองมีค่าเหมือนกัน (row[size - 1 - board.indexOf(row)] == board[0][size - 1])
ทุกช่องไม่เป็น null
ถ้าเงื่อนไขนี้เป็นจริง: คืนค่าผู้เล่นที่ชนะในแนวทแยงรอง (return board[0][size - 1])
การตรวจสอบกระดานเต็ม (Full Table)
การทำงาน:
ใช้ .every เพื่อตรวจสอบว่า:
ทุกช่องในกระดานไม่เป็น null (แสดงว่ากระดานเต็ม)
ถ้ากระดานเต็ม: คืนค่า 'Draw'
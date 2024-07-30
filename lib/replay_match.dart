import 'package:flutter/material.dart';

class ReplayMatch extends StatelessWidget {
  final int size;
  final List<dynamic> board;
  final String winner;
  final String timestamp;

  ReplayMatch({
    required this.size,
    required this.board,
    required this.winner,
    required this.timestamp,
  });

  // ฟังก์ชันเพื่อเช็คสีของเซลล์
  Color _getCellColor(int row, int col) {
    if (winner == 'X') {
      // เปลี่ยนสีของเซลล์ที่เป็นผู้ชนะ (ถ้า 'X' เป็นผู้ชนะ)
      return board[row][col] == 'X'
          ? Colors.green
          : Color.fromARGB(255, 248, 219, 121);
    } else if (winner == 'O') {
      // เปลี่ยนสีของเซลล์ที่เป็นผู้ชนะ (ถ้า 'O' เป็นผู้ชนะ)
      return board[row][col] == 'O'
          ? Colors.red
          : Color.fromARGB(255, 248, 219, 121);
    } else {
      // สีปกติ
      return Color.fromARGB(255, 248, 219, 121);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replay Match'),
      ),
      body: Column(
        children: [
          // กล่องสีเหลี่ยมโค้ง
          Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Winner: $winner',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Match Time: $timestamp',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          // ตาราง
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size,
                ),
                itemCount: size * size,
                itemBuilder: (context, index) {
                  int row = index ~/ size;
                  int col = index % size;
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: _getCellColor(row, col),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        board[row][col] ?? '',
                        style: const TextStyle(fontSize: 32.0),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

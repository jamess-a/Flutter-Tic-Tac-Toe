import 'package:flutter/material.dart';
import 'game_logic.dart';
import 'db/database_helper.dart';
import 'match_history.dart';
import 'replay_match.dart';
import 'Table.dart';

void main() => runApp(TicTacToeApp());

class TicTacToeApp extends StatefulWidget {
  @override
  _TicTacToeAppState createState() => _TicTacToeAppState();
}

class _TicTacToeAppState extends State<TicTacToeApp> {
  int boardSize = 3;
  late Game game;
  String? winner;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    game = Game(boardSize);
  }

  void resetGame(int size) {
    setState(() {
      boardSize = size;
      game = Game(boardSize);
      winner = null;
    });
  }

  void saveMatch() async {
    if (winner != null) {
      await dbHelper.insertMatch(game, winner!);
    }
  }

  Widget buildCell(int row, int col) {
    return GestureDetector(
      onTap: () {
        if (winner == null && game.makeMove(row, col)) {
          setState(() {
            winner = game.checkWinner();
            if (winner != null) saveMatch();
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(12.0), // มุมโค้งของแต่ละเซลล์
        ),
        child: Center(
          child: Text(
            game.board[row][col] ?? '',
            style: const TextStyle(fontSize: 32.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomeScreen(),
        '/matchHistory': (context) => MatchHistory(),
        '/table': (context) => const TestPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/replayMatch') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ReplayMatch(
                size: args['size'],
                board: args['board'],
                winner: args['winner'],
                timestamp: args['times'],
              );
            },
          );
        }
        return null;
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int boardSize = 3;
  late Game game;
  String? winner;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    game = Game(boardSize);
  }

  void resetGame(int size) {
    setState(() {
      boardSize = size;
      game = Game(boardSize);
      winner = null;
    });
  }

  void saveMatch() async {
    if (winner != null) {
      await dbHelper.insertMatch(game, winner!);
    }
  }

  Widget buildCell(int row, int col) {
    return GestureDetector(
      onTap: () {
        if (winner == null && game.makeMove(row, col)) {
          setState(() {
            winner = game.checkWinner();
            if (winner != null) {
              saveMatch();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                          winner == 'Draw' ? 'It\'s a Draw!' : '$winner Wins!'),
                    ),
                    content: const Text(
                      textAlign: TextAlign.center,
                      'Match saved successfully!',
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          "Restart",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          resetGame(boardSize);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            game.board[row][col] ?? '',
            style: const TextStyle(fontSize: 32.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.history,
              size: 50,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/matchHistory');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<int>(
            value: boardSize,
            items: [3, 4, 5, 6].map((size) {
              return DropdownMenuItem<int>(
                value: size,
                child: Text(
                  '$size x $size',
                  style: const TextStyle(fontSize: 24.0),
                ),
              );
            }).toList(),
            onChanged: (size) {
              if (size != null) {
                resetGame(size);
              }
            },
          ),
          const SizedBox(height: 40.0),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: boardSize,
                  ),
                  itemCount: boardSize * boardSize,
                  itemBuilder: (context, index) {
                    int row = index ~/ boardSize;
                    int col = index % boardSize;
                    return buildCell(row, col);
                  },
                ),
              ),
            ),
          ),
          if (winner != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text(
                            winner == 'Draw'
                                ? 'It\'s a Draw!'
                                : '$winner Wins!',
                            style: const TextStyle(fontSize: 24.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => resetGame(boardSize),
              child: const Text(
                'Restart',
                style: TextStyle(fontSize: 24.0, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

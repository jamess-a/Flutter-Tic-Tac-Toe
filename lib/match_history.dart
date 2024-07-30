import 'dart:convert';
import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'replay_match.dart';

class MatchHistory extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> _deleteAllMatches(BuildContext context) async {
    final shouldDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content:
            const Text('Are you sure you want to delete all match history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete) {
      await dbHelper.deleteAllMatches();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All match history deleted')),
      );
      (context as Element).reassemble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteAllMatches(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getMatches(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final matches = snapshot.data!;
          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              final board = jsonDecode(match['board']);
              final size = match['size'];
              final winner = match['winner'];
              final timestamp = match['times'];

              Color _getCellColor(String winner) {
                if (winner == 'X') {
                  return winner == 'X'
                      ? Colors.green
                      : Color.fromARGB(255, 255, 255, 255);
                } else if (winner == 'O') {
                  return winner == 'O'
                      ? Colors.red
                      : Color.fromARGB(255, 255, 255, 255);
                } else {
                  return Color.fromARGB(255, 255, 255, 255);
                }
              }

              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: _getCellColor(winner),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text('Size: $size x $size, Winner: $winner'),
                  subtitle: Text('Matched: $timestamp'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReplayMatch(
                          size: size,
                          board: board,
                          winner: winner,
                          timestamp: timestamp,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

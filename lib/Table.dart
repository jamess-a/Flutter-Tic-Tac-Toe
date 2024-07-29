import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Future<List<Map<String, dynamic>>> _fetchTableSchema() async {
    String path = join(await getDatabasesPath(), 'matches1.db');
    final db = await openDatabase(path);

    final result = await db.rawQuery('PRAGMA table_info(matches)');
    await db.close();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Schema'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchTableSchema(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No table schema found.'));
          } else {
            final schema = snapshot.data!;
            return ListView(
              children: schema.map((row) {
                return ListTile(                  title: Text(
                    'Column: ${row['name']}, Type: ${row['type']}, Not Null: ${row['notnull'] == 1 ? 'Yes' : 'No'}, Default: ${row['dflt_value']}',
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

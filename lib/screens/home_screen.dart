import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _todoItems = []; // TODOリストを保持するリスト

  // 新しいタスクを追加する
  void _addTodoItem(String task) {
    setState(() {
      _todoItems.add(task);
    });
  }

  // タスクを削除する
  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  // タスク追加ダイアログを表示する
  void _displayAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';
        return AlertDialog(
          title: const Text('新しいタスクを追加'),
          content: TextField(
            onChanged: (String value) {
              newTask = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('追加'),
              onPressed: () {
                _addTodoItem(newTask);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_todoItems[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _removeTodoItem(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayAddTodoDialog,
        tooltip: 'タスクを追加',
        child: const Icon(Icons.add),
      ),
    );
  }
}

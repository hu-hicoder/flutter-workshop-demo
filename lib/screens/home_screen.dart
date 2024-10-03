import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// タスクのタイトルと内容を保持するクラス
class TodoItem {
  String title;
  String content;
  bool isDone;

  TodoItem(this.title, this.content, {this.isDone = false});
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TodoItem> _todoItems = []; // TODOリストを保持するリスト

  // 新しいタスクを追加する
  void _addTodoItem(String title, String content) {
    setState(() {
      _todoItems.add(TodoItem(title, content));
    });
  }

  // タスクを削除する
  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  // タスクの完了状態をトグルする
  void _toggleTodoDone(int index) {
    setState(() {
      _todoItems[index].isDone = !_todoItems[index].isDone;
    });
  }

  // タスク追加ダイアログを表示する
  void _displayAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitle = '';
        String newContent = '';
        return AlertDialog(
          title: const Text('新しいタスクを追加'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (String value) {
                  newTitle = value;
                },
                decoration: const InputDecoration(hintText: 'タイトル'),
              ),
              TextField(
                onChanged: (String value) {
                  newContent = value;
                },
                decoration: const InputDecoration(hintText: '内容'),
              ),
            ],
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
                _addTodoItem(newTitle, newContent);
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
            leading: Checkbox(
              value: _todoItems[index].isDone,
              onChanged: (bool? value) {
                _toggleTodoDone(index);
              },
            ),
            title: Text(
              _todoItems[index].title,
              style: TextStyle(
                  decoration: _todoItems[index].isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            subtitle: Text(_todoItems[index].content,
                style: const TextStyle(color: Colors.grey)),
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

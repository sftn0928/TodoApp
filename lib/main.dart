import 'package:flutter/material.dart';
import 'package:todo/add_todo.dart';
import 'package:todo/todo_App.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 右上に表示される"debug"ラベルを消す
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: TodoApp(),
      // ルーティング名称に対して、表示されるページを作成しウィジェットを設定
      // routes: <String, WidgetBuilder> {
      //   '/home': (BuildContext context) => new TodoApp(),
      // },
    );
  }
}

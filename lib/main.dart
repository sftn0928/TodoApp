import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/add_todo.dart';
import 'package:todo/edit_todo.dart';
import 'package:todo/main_model.dart';
import 'package:todo/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SignIn(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..getTodoListRealtime(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo一覧画面'),
        ),
        body: Consumer<MainModel>(builder: (context, model, child) {
          final todoList = model.todoList;
          return ListView(
              children: todoList
                  .map((todo) => ListTile(
                        title: Text(todo.title),
                        leading: IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () async {
                            await model.deleteTodoList(todo);
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            final updateText = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTodo(),
                              ),
                            );
                            await model.updateTodoList(todo, updateText);
                          },
                        ),
                      ))
                  .toList());
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodo()),
              );
            }),
      ),
    );
  }
}

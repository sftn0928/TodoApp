import 'package:flutter/material.dart';

import 'add_todo.dart';
import 'edit_todo.dart';

class TodoApp extends StatefulWidget {

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List listItem = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo一覧画面'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black38),
                ),
              ),
              child: ListTile(
                leading: const Icon(Icons.done),
                title: Text(listItem[index]),
                subtitle: Text('$index'),
                trailing: Icon(Icons.edit),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('項目を削除または変更する'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("戻る"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: Text("削除"),
                              onPressed: () {
                                setState(() {
                                  listItem.remove(listItem[index]);
                                });
                                Navigator.pop(context);
                              }
                          ),
                          FlatButton(
                            child: Text("変更"),
                              onPressed: () async {
                                final changeText = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context,) => EditTodo()),
                                );
                                setState(() {
                                  listItem[index] = changeText;
                                });
                                Navigator.pop(context);
                              }
                          ),
                        ],
                      );
                    },
                  );
                },
              ));
        },
        itemCount: listItem.length,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final getText = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTodo()),
            );
            setState(() {
              listItem.add(getText);
            });
          }),
    );
  }
}

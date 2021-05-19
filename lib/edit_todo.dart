import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main_model.dart';
import 'package:todo/todo.dart';

class EditTodo extends StatelessWidget {
  var _inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Todo編集画面'),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 0),
                  child: TextField(
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '変更後',
                    ),
                    controller: _inputTextController,
                  ),
                ),
                RaisedButton(
                    child: Text("追加する"),
                    color: Colors.white,
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.indigo),
                    ),
                    onPressed: () {
                      if (_inputTextController.text != '') {
                        Navigator.pop(context, _inputTextController.text);
                      }
                    }),
              ],
            );
          }),
        ));
  }
}

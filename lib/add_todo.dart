import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main_model.dart';

class AddTodo extends StatelessWidget {
  var _inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Todo追加画面'),
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
                      hintText: '追加したい項目を入力',
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
                    onPressed: () async {
                      if (_inputTextController.text != '') {
                        await model.addTodoList(_inputTextController.text);
                        Navigator.pop(context);
                      }
                    }),
              ],
            );
          }),
        ));
  }
}

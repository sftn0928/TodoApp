import 'package:flutter/material.dart';

class EditTodo extends StatefulWidget {
  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  //入力したものを扱うコントローラ
  var _inputTextController = TextEditingController();

  String _inputText = '';

  void setText(String value) {
    setState(() {
      _inputText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TODO変更画面"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 200, 20, 0),
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '変更後の項目を入力',
                ),
                controller: _inputTextController,
              ),
            ),
            RaisedButton(
                child: Text("変更する"),
                color: Colors.white,
                shape: const StadiumBorder(
                  side: BorderSide(color: Colors.indigo),
                ),
                onPressed: () {
                  setText(_inputTextController.text);
                  // テキストフィールドの内容をクリア
                  _inputTextController.clear();
                  if (_inputText != '') {
                    Navigator.pop(context, _inputText);
                  }
                }),
          ],
        ));
  }
}

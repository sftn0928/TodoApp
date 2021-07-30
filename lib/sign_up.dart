import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/sign_model.dart';

import 'main.dart';

class SignUp extends StatelessWidget {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignModel>(
        create: (_) => SignModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('会員登録画面'),
          ),
          body: Consumer<SignModel>(builder: (context, model, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'メールアドレス',
                    ),
                    controller: _emailController,
                    onChanged: (text) {
                      model.mail = text;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'パスワード',
                    ),
                    controller: _passwordController,
                    onChanged: (text) {
                      model.password = text;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: RaisedButton(
                      child: Text("会員登録する"),
                      color: Colors.white,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.indigo),
                      ),
                      onPressed: () async {
                        try {
                          await model.signUp();
                          _showDialog(context, '登録完了しました');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ),
                          );
                        } catch (e) {
                          _showDialog(context, e.toString());
                        }
                      }),
                ),
              ],
            );
          }),
        ));
  }
}

Future _showDialog(
  BuildContext context,
  String title,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

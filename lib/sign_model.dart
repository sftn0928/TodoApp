import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }
    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }
    // final User user = (await _auth.createUserWithEmailAndPassword(
    //   email: mail,
    //   password: password,
    // ))
    //     .user;
    // final email = user.email;
    // FirebaseFirestore.instance.collection('users').add(
    //   {
    //     'email': email,
    //     'createdAt': Timestamp.now(),
    //   },
    // );

    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
              email: mail, password: password))
          .user;
      // user;
      final email = user.email;
      FirebaseFirestore.instance.collection('users').add(
        {
          'email': email,
          'createdAt': Timestamp.now(),
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signIn() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }
    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }
    // todo
    final result = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    final uid = result.user.uid;
    return uid;
    // TODO 端末に保存
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

// class SignInModel extends ChangeNotifier {
//   String mail = '';
//   String password = '';
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future signIn() async {
//     if (mail.isEmpty) {
//       throw ('メールアドレスを入力してください');
//     }
//     if (password.isEmpty) {
//       throw ('パスワードを入力してください');
//     }
//     // todo
//     final result = await _auth.signInWithEmailAndPassword(
//       email: mail,
//       password: password,
//     );
//     final uid = result.user.uid;
//     return uid;
//     // TODO 端末に保存
//   }
// }

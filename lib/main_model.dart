import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/todo.dart';

class MainModel extends ChangeNotifier {
  List<Todo> todoList = [];

  // Future getTodoList() async {
  //   final snapshot =
  //       await FirebaseFirestore.instance.collection('todoList').get();
  //   final docs = snapshot.docs;
  //   final todoList = docs.map((doc) => Todo(doc)).toList();
  //   this.todoList = todoList;
  //   notifyListeners();
  // }

  void getTodoListRealtime() {
    final currentUser = FirebaseAuth.instance.currentUser;
    final snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection("todoList")
        .orderBy("createdAt", descending: true)
        .snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final todoList = docs.map((doc) => Todo(doc)).toList();
      this.todoList = todoList;
      notifyListeners();
    });
  }

  Future addTodoList(String inputText) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('todoList');
    await collection.add({
      'title': inputText,
      'createdAt': Timestamp.now(),
    });
    notifyListeners();
  }

  // Future addTodoList(String inputText) async {
  //   final collection = FirebaseFirestore.instance.collection('todoList');
  //   await collection.add({
  //     'title': inputText,
  //     'createdAt': Timestamp.now(),
  //   });
  //   notifyListeners();
  // }

  void reload() {
    notifyListeners();
  }

  Future deleteTodoList(Todo todo) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final docID = todo.documentReference.id;
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('todoList');
    await collection.doc(docID).delete();
    notifyListeners();
  }

  Future updateTodoList(Todo todo, String updateText) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final docID = todo.documentReference.id;
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('todoList');
    await collection.doc(docID).update({
      'title': updateText,
      'createdAt': Timestamp.now(),
    });
    notifyListeners();
  }
}

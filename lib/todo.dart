import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Todo(DocumentSnapshot doc) {
    this.documentReference = doc.reference;

    final map = doc.data() as Map;
    this.title = map['title'];
    final Timestamp timestamp = map['createdAt'];
    this.createdAt = timestamp.toDate();
  }

  String title;
  DateTime createdAt;
  DocumentReference documentReference;
}

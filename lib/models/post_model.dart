import 'package:firebase_database/firebase_database.dart';

class Post {
  static const DATE = "date";
  static const KEY = "Key";
  static const TITLE = "title";
  static const DESCRIPTION = "description";
  int date;
  String title, description;
  String key;
  Post(this.date, this.title, this.description);

  Post.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key,
        this.date = snap.value[DATE],
        this.title = snap.value[TITLE],
        this.description = snap.value[DESCRIPTION];
  Map toMap() {
    return {DATE: date, TITLE: title, DESCRIPTION: description};
  }
}

import 'package:firebase_database/firebase_database.dart';
import '../models/post_model.dart';

class PostService {
  String node = "posts";
  FirebaseDatabase db = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  addPost(Post post) {
    _databaseReference = db.reference().child(node);
    _databaseReference.push().set(post.toMap());
  }
}

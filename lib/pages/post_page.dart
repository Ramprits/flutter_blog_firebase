import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import '../models/post_model.dart';
import 'add_post_page.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Post> postList = <Post>[];
  _onChildAdded(Event event) {
    setState(() {
      postList.add(Post.fromSnapshot(event.snapshot));
    });
  }

  @override
  void initState() {
    _database.reference().child("posts").onChildAdded.listen(_onChildAdded);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Visibility(
            visible: postList.isEmpty,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Visibility(
            visible: postList.isNotEmpty,
            child: Flexible(
              child: FirebaseAnimatedList(
                query: _database.reference().child("posts"),
                itemBuilder: (_, DataSnapshot snap, Animation<double> animation,
                    int index) {
                  return Column(
                    children: <Widget>[
                      Card(
                        elevation: 8.0,
                        child: ListTile(
                          title: Text(
                            postList[index].title,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(timeAgo.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  postList[index].date))),
                          subtitle: Text(postList[index].description),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostPage(),
            ),
          );
        },
        tooltip: 'Add Post',
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:flutter/material.dart';

import 'add_post_page.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              trailing: Icon(Icons.security),
              title: Text(
                "Angular 8 ",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              trailing: Icon(Icons.send),
              title: Text(
                "Reactjs",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
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

import 'package:flutter/material.dart';
import 'package:flutter_blog/database/post_service.dart';
import '../models/post_model.dart';

import '../color.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key key}) : super(key: key);

  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Post post;

  @override
  void initState() {
    super.initState();
    post = Post(0, "", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Post"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 40.0),
              Center(
                child: Text(
                  'Create post here...',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              SizedBox(height: 20.0),
              AccentColorOverride(
                color: kShrineBrown900,
                child: TextFormField(
                  controller: _title,
                  onSaved: (value) {
                    post.title = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) return "Title can't be empty";
                  },
                  decoration: InputDecoration(
                      labelText: 'Title', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 12.0),
              AccentColorOverride(
                color: kShrineBrown900,
                child: TextFormField(
                  onSaved: (value) {
                    post.description = value;
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Description can't be empty";
                    }
                  },
                  maxLines: 4,
                  controller: _description,
                  decoration: InputDecoration(
                      labelText: 'Description', border: OutlineInputBorder()),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('CANCEL'),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    onPressed: () {
                      _title.clear();
                      _description.clear();
                    },
                  ),
                  RaisedButton(
                    child: Text('Save'),
                    elevation: 8.0,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    onPressed: _savePost,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _savePost() {
    final _formData = _formKey.currentState;
    if (_formData.validate()) {
      _formData.save();
      post.date = DateTime.now().millisecondsSinceEpoch;
      final postService = PostService();
      postService.addPost(post);
    }
  }
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}

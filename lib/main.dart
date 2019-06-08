import 'package:flutter/material.dart';

import 'pages/post_page.dart';

void main() => runApp(FlutterBlog());

class FlutterBlog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (BuildContext context) => PostPage(
              title: "Flutter Blog",
            )
      },
    );
  }
}

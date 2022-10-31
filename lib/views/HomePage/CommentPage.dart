import 'package:flutter/material.dart';
import 'package:groupproject/views/HomePage/HomeScreenBuilder.dart';
import 'package:provider/provider.dart';

import '../../models/Post.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  get index => null;



  @override
  Widget build(BuildContext context) {

    PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context);
    print("$index");
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                buildLongPost(context, selectedIndex),
              ],
            ),
          ),
        ],
      )
    );
  }
}

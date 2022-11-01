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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: buildLongPost(context, selectedIndex),
          ),

          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12)
            ),
            child: Row(
              children: [
                const Text(
                  "Comments",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
                const SizedBox(width: 15,),
                Text("${postsListBLoC.posts[selectedIndex!].comments.length!}"),
              ],
            ),
          ),

          ListView.builder(
              shrinkWrap: true,
              itemCount: postsListBLoC.posts[selectedIndex!].comments.length,
              itemBuilder: (context, index){
                index-1;
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  child:buildCommentSection(context, index),
                );
              }
          ),

        ],
      )
    );
  }
}

Widget buildCommentSection(context, index){

  PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context);

  return Container(
      padding: EdgeInsets.all(15),
      child: Text(
          postsListBLoC.posts[selectedIndex!].comments[index]
      )
  );
}

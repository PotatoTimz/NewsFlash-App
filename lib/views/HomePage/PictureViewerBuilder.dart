import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Post.dart';
import 'HomeScreenBuilder.dart';

class PictureViewerBuilder extends StatefulWidget {
  const PictureViewerBuilder({Key? key}) : super(key: key);

  @override
  State<PictureViewerBuilder> createState() => _PictureViewerBuilderState();
}

class _PictureViewerBuilderState extends State<PictureViewerBuilder> {
  @override
  Widget build(BuildContext context) {

    PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context);

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2)
        ,
        itemCount: postsListBLoC.posts.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = index;
                // print("index $index");
              });
            },
            onDoubleTap: (){
              setState(() {
                selectedIndex = index;
                goToCommentPage(context);
              });
            },
            child: Container(
              decoration: BoxDecoration(color: selectedIndex != index ? Colors.white : Colors.black12 ),
              padding: EdgeInsets.all(10),
              child: Image.network(
                "${postsListBLoC.posts[index].imageURL}",
                fit: BoxFit.fill,
              ),
            ),
          );
        }
    );
  }
}

Future<void> goToCommentPage(context) async{
  var newPost = await Navigator.pushNamed(context, r'/commentPage');
}


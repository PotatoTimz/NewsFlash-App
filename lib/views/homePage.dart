import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Post.dart';

List<Post> allPosts= [];

void initializeAllPosts(){
  allPosts= [
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        description: "words words words words words words words words words words words words",
        imageURL: "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg"),
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        description: "words words words words words words words words words words words words",
        imageURL: "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg"),
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        description: "words words words words words words words words words words words words",
        imageURL: "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg"),
  ];
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {

  @override
  void initState() {
    super.initState();
    initializeAllPosts();
    //print(allPosts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(widget.title!)),
      body: ListView.builder(
          itemCount: allPosts.length,
          itemBuilder: (context, index){
            return Column(
                children: [

                  //Username and time of post
                  Row(
                    children: [
                      Text(" ${allPosts[index].userName}"),
                      const SizedBox(width: 50),
                      Text("${allPosts[index].timeString}")
                    ],
                  ),

                  //Description
                  Text("${allPosts[index].description}", textAlign:TextAlign.justify),

                  //Image
                  Image.network("${allPosts[index].imageURL}"),                                                  //image section

                  Row(                                                                      //like, comment, retweet, bookmark section
                    children: <Widget>[
                      const Icon(Icons.chat_bubble_outline, size: 20,),
                      Text("  ${allPosts[index].numComments}"),
                      const SizedBox(width: 20),

                      const Icon(Icons.repeat, size: 20),
                      Text(" ${allPosts[index].numRetweets}"),
                      const SizedBox(width: 20),

                      const Icon(Icons.favorite_border, size: 20),
                      Text("  ${allPosts[index].numLikes}"),
                      const SizedBox(width: 20),

                      const Icon(Icons.bookmark_border, size: 20)
                    ],
                  ),

                ],
            );
          }
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../models/Post.dart';

class CommentPage extends StatefulWidget {

  final Post? post;

  const CommentPage({Key? key, this.post}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {

    final routeData = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    final Post postData = routeData['post'] as Post;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.of(context).pop(postData);
          },
        ),
        title: const Text("Post Viewer"),
      ),
      body: ListView(
        children: [

          Container(
            padding: EdgeInsets.all(15),
            child: buildLongPost(postData),
          ),

          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12)
            ),
            child: Row(
              children: const [
                Text("Comments", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              ],
            ),
          ),

          ListView.builder(
              shrinkWrap: true,
              itemCount: postData.comments?.length,
              itemBuilder: (context, index){
                index-1;
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  child:buildCommentSection(postData, index),
                );
              }
          ),
        ],
      ),

    );
  }
}

Widget buildCommentSection(post, index){

  return Container(
      padding: EdgeInsets.all(15),
      child: Text(
          post.comments[index]
      )
  );
}

Widget buildLongPost(post){

  return Column(
    children: [
      //Username and settings button
      Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                radius: 20,
                child: Text("AA", textScaleFactor: 1),
              ),
              const SizedBox(width: 20),
              Text(
                  "${post.userName}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
        ],
      ),
      SizedBox(height: 10),

      //time
      Row(
        children: [
          Text("${post.timeString}",
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15)
          ),
        ],
      ),
      const SizedBox(height: 10),

      //Title
      Text(
        "${post.title}",
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 30),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 10),

      //Description
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "${post.longDescription}",
          style: const TextStyle(fontSize: 15),
        ),
      ),
      const SizedBox(height: 20),

      //Image
      Image.network("${post.imageURL}", fit: BoxFit.fill,),
      const SizedBox(height: 20,),

    ],
  );
}
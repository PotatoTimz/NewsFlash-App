import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Post.dart';


Widget buildShortPost(context, index){
  PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context);

  return Column(
    children: [
      //Username and settings button
      Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                radius: 15,
                child: Text("AA", textScaleFactor: 1),
              ),
              const SizedBox(width: 20),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      "${postsListBLoC.posts[index].userName}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  IconButton(
                    onPressed: () {
                      postsListBLoC.removePost(index);
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              )
            ],
          ),
        ],
      ),

      //time
      Row(
        children: [
          Text("${postsListBLoC.posts[index].timeString}",
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 10)
          ),
        ],
      ),
      const SizedBox(height: 10),

      //Title
      Text(
        "${postsListBLoC.posts[index].title}",
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 10),

      //Description
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "${postsListBLoC.posts[index].shortDescription}",
          style: const TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: Colors.black54
          ),
        ),
      ),
      const SizedBox(height: 20),

      //Image
      Image.network("${postsListBLoC.posts[index].imageURL}"),
      //image section
      const SizedBox(height: 20,),
    ],
  );
}


Widget buildLongPost(context, index){

  PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context);

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
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      "${postsListBLoC.posts[index].userName}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  IconButton(
                    onPressed: () {
                      postsListBLoC.removePost(index);
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              )
            ],
          ),
        ],
      ),

      //time
      Row(
        children: [
          Text("${postsListBLoC.posts[index].timeString}",
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15)
          ),
        ],
      ),
      const SizedBox(height: 10),

      //Title
      Text(
        "${postsListBLoC.posts[index].title}",
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 30),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 10),

      //Description
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "${postsListBLoC.posts[index].longDescription}",
          style: const TextStyle(fontSize: 15),
        ),
      ),
      const SizedBox(height: 20),

      //Image
      Image.network("${postsListBLoC.posts[index].imageURL}"),
      //image section
      const SizedBox(height: 20,),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.chat_bubble_outline,
              size: 20,
            ),
          ),
          Text("  ${postsListBLoC.posts[index].numComments}"),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              postsListBLoC.increaseReposts(index);
              // print("Number of Reposts: ${postsListBLoC.posts[index].numReposts}");
            },
            icon: const Icon(Icons.repeat, size: 20),
          ),
          Text(" ${postsListBLoC.posts[index].numReposts}"),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              postsListBLoC.increaseLikes(index);
              // print("Number of Likes: ${postsListBLoC.posts[index].numLikes}");
            },
            icon:
            const Icon(Icons.thumb_up_outlined, size: 20),
          ),
          Text("  ${postsListBLoC.posts[index].numLikes}"),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              postsListBLoC.increaseDislikes(index);
              // print("Number of Dislikes: ${postsListBLoC.posts[index].numDislikes}");
            },
            icon: const Icon(Icons.thumb_down_outlined,
                size: 20),
          ),
          Text("  ${postsListBLoC.posts[index].numDislikes}"),
        ],
      ),
    ],
  );
}

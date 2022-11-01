import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Post.dart';

int? selectedIndex;

class ListViewHomePage extends StatefulWidget {
  const ListViewHomePage({Key? key}) : super(key: key);

  @override
  State<ListViewHomePage> createState() => _ListViewHomePageState();
}

class _ListViewHomePageState extends State<ListViewHomePage> {

  @override
  Widget build(BuildContext context) {

    PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context);

    return  ListView.builder(
        itemCount: postsListBLoC.posts.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    // print("selected index $selectedIndex");
                  });
                },
                onLongPress: (){
                  setState(() {
                    selectedIndex = 1^1000;
                  });
                },
                onDoubleTap: (){
                  selectedIndex = index;
                  goToCommentPage(context);
                },
                child: Container(
                  decoration: BoxDecoration(color: selectedIndex != index ? Colors.white : Colors.black12 ),
                  padding: const EdgeInsets.all(15),
                  child: selectedIndex != index ? buildShortPost(context, index) : buildLongPost(context, index),
                )
            ),
          );
        }
    );
  }
}

Future<void> goToCommentPage(context) async{
  var newPost = await Navigator.pushNamed(context, r'/commentPage');
}

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
                      _showPostOptions(context, index);
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
                      _showPostOptions(context, index);
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
      Image.network("${postsListBLoC.posts[index].imageURL}", fit: BoxFit.fill,),
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
          Text("  ${postsListBLoC.posts[index].comments?.length}"),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.repeat, size: 20),
          ),
          Text(" ${postsListBLoC.posts[index].numReposts}"),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
            },
            icon:
            const Icon(Icons.thumb_up_outlined, size: 20),
          ),
          Text("  ${postsListBLoC.posts[index].numLikes}"),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
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

_showPostOptions(context, index){
  showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          title: const Text("What would you like to do"),
          children: [
            SimpleDialogOption(
                onPressed: (){
                  Navigator.of(context).pop();
                  goToUpdatePostPage(context, index);
                },
                child: const Text("Edit post")
            ),
            SimpleDialogOption(
                onPressed: (){
                  Navigator.of(context).pop();
                  _showDeleteDialog(context, index);
                },
                child: const Text("Delete post")
            ),
            SimpleDialogOption(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text("Save post")
            ),
          ],
        );
      }
  );
}

_showDeleteDialog(context, index){
  PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context, listen: false);

  showDialog(context: context,
      barrierDismissible: false,                              //doesnt allow user to click of alert pop up
      builder: (context){
        return AlertDialog(
          title: const Text("Delete Post"),
          content: const Text("Are you sure you would like to delete this post"),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Cancel")
            ),
            TextButton(
                onPressed: (){
                  postsListBLoC.removePost(index);
                  Navigator.of(context).pop();
                },
                child: Text("Delete")
            )
          ],
        );
      }
  );
}

Future<void> goToUpdatePostPage(context, index) async{
  PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context, listen: false);

  var newPost = await Navigator.pushNamed(context, r'/createPostPage');
  postsListBLoC.updatePost(index, newPost);
}
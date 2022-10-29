import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Post.dart';
import 'buildPostList.dart';

int? selectedIndex;

void initializeAllPosts() {
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

    PostsListBLoC postsListBLoC = context.watch<PostsListBLoC>();

    return Scaffold(
      appBar: AppBar(title: Text(widget.title!)),
      body: ListView.builder(
          itemCount: postsListBLoC.posts.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Form(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        // print("selected index $selectedIndex");
                        print("${postsListBLoC.posts[1]}");
                      });
                    },
                    onDoubleTap: (){
                      setState(() {
                        selectedIndex = 1^1000;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(color: selectedIndex != index ? Colors.white : Colors.black12 ),
                      child: selectedIndex != index ? buildShortPost(context, index) : buildLongPost(context, index),
                      padding: const EdgeInsets.all(15),
                    )
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          goToCreatePostPage(context);
        },
        tooltip: 'Make Post',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> goToCreatePostPage(context) async{

    PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context, listen: false);

    var newPost = await Navigator.pushNamed(context, r'/createPostPage');
    postsListBLoC.addPost(newPost);
  }
}


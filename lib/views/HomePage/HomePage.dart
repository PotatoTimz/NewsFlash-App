import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:groupproject/views/HomePage/PictureViewerBuilder.dart';
import 'package:provider/provider.dart';

import '../../models/Post.dart';
import 'HomeScreenBuilder.dart';


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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
        ),

        body: const TabBarView(
          children:[
            ListViewHomePage(),
            PictureViewerBuilder(),
            Text("work in progress")
          ],
        ),

        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Colors.lightBlue),
          child: const TabBar(
            tabs: [
              Tab(text: "HomeScreen", icon: Icon(Icons.home),),
              Tab(text: "PictureViewer", icon: Icon(Icons.photo)),
              Tab(text: "Polls and Surveys", icon: Icon(Icons.poll))
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            goToCreatePostPage(context);
          },
          tooltip: 'Make Post',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> goToCreatePostPage(context) async{

    PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context, listen: false);

    var newPost = await Navigator.pushNamed(context, r'/createPostPage');
    postsListBLoC.addPost(newPost);
  }


}


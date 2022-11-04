import 'package:flutter/material.dart';
import 'package:groupproject/views/HomePageTabs/PictureViewerBuilder.dart';
import 'package:groupproject/views/HomePageTabs/OnlineHomeScreenBuilder.dart';
import 'package:groupproject/views/HomePageTabs/ProfilePageBuilder.dart';
import 'package:groupproject/views/SearchPage.dart';
import 'package:provider/provider.dart';
import '../models/Post.dart';
import 'HomePageTabs/FireBaseEditors.dart';
import 'HomePageTabs/OfflineHomeScreenBuilder.dart';


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
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
          actions: [
            IconButton(onPressed: () {
              showSearch(context: context, delegate: SearchPage());
            }, icon: const Icon(Icons.search))
          ],
        ),

        body: const TabBarView(
          children:[
            TestListView(),
            PictureViewerBuilder(),
            Text("work in progress"),
            ListViewHomePage(),
            ProfilePageBuilder(),
          ],
        ),

        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Colors.lightBlue),
          child: const TabBar(
            tabs: [
              Tab(text: "HomeScreen", icon: Icon(Icons.home),),
              Tab(text: "PictureViewer", icon: Icon(Icons.photo)),
              Tab(text: "Polls and Surveys", icon: Icon(Icons.poll)),
              Tab(text: "Offline Viewer", icon: Icon(Icons.download)),
              Tab(text: "Profile", icon: Icon(Icons.account_box)),
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
    if (newPost == null){
      print("Nothing was inputed");
    }
    else{
      insertPost(newPost);
    }
  }


}

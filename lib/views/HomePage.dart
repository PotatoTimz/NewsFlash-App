import 'package:flutter/material.dart';
import 'package:groupproject/views/HomePageTabs/PictureViewMode/PictureViewerBuilder.dart';
import 'package:groupproject/views/SearchPage.dart';
import 'package:provider/provider.dart';
import '../models/PostOffline.dart';
import '../models/PostOnline.dart';
import 'DatabaseEditors.dart';
import 'HomePageTabs/OfflineDatabase/OfflineHomeScreenBuilder.dart';
import 'HomePageTabs/OfflineDatabase/post_model.dart';
import 'HomePageTabs/OnlineViewMode/OnlineHomeScreenBuilder.dart';

var model = PostModel();
int lastInsertedId = 0;

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
    initializeOfflineDataBase(context);
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
          actions: [
            IconButton(onPressed: () {
              showSearch(context: context, delegate: SearchPage());
            }, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: (){
                  readOfflineDatabase();
                },
                icon: Icon(Icons.data_object)
            ),
          ],
        ),

        body: TabBarView(
          children:[
            OnlineHomeScreen(),
            PictureViewerBuilder(),
            Text("work in progress"),
            OfflineHomeScreen(),
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

    var newPost = await Navigator.pushNamed(context, r'/createPostPage');
    if (newPost == null){
      print("Nothing was inputed");
    }
    else{
      insertOnlineDatabase(newPost);
    }
  }


}

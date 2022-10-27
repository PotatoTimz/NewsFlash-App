import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Post.dart';

List<Post> allPosts = [];

void initializeAllPosts() {
  allPosts = [
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        description:
            "Lambda calculus (also written as λ-calculus) is a formal system in mathematical logic for expressing computation based on function abstraction and application using variable binding and substitution. It is a universal model of computation that can be used to simulate any Turing machine.",
        imageURL:
            "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg",
        title: "Test Title MUST BE VERY LONG"),
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        description:
            "words words words words words words words words words words words words",
        imageURL:
            "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg",
        title: "Test Title"),
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

    PostsListBLoC postsListBLoC = context.watch<PostsListBLoC>();

    return Scaffold(
      appBar: AppBar(title: Text(widget.title!)),
      body: buildPostList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: goToCreatePostPage,
        tooltip: 'Make Post',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> goToCreatePostPage() async{
    var loginStatus = await Navigator.pushNamed(context, r'/createPostPage');
  }

}

Widget buildPostList(context){

  PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context);
  TextStyle defaultStyle = TextStyle(fontSize: 15);

  return ListView.builder(
      itemCount: postsListBLoC.posts.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
          ),
          child: Form(
            child: GestureDetector(
                onTap: () {
                  print("${postsListBLoC.posts[1]}");
                },
                child: Column(
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
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${postsListBLoC.posts[index].userName}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.more_vert),
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
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 10),

                    //Title
                    Text(
                      "${postsListBLoC.posts[index].title}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),

                    //Description
                    Text(
                      "${postsListBLoC.posts[index].description}",
                      textAlign: TextAlign.justify,
                      style: defaultStyle,
                    ),
                    SizedBox(height: 20),

                    //Image
                    Image.network("${postsListBLoC.posts[index].imageURL}"),
                    //image section
                    SizedBox(
                      height: 20,
                    ),

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
                            postsListBLoC.posts[index].numReposts++;
                            print(
                                "Number of Likes: ${postsListBLoC.posts[index].numReposts}");
                          },
                          icon: const Icon(Icons.repeat, size: 20),
                        ),
                        Text(" ${postsListBLoC.posts[index].numReposts}"),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            postsListBLoC.posts[index].numLikes++;
                            print(
                                "Number of Likes: ${postsListBLoC.posts[index].numLikes}");
                          },
                          icon:
                          const Icon(Icons.thumb_up_outlined, size: 20),
                        ),
                        Text("  ${postsListBLoC.posts[index].numLikes}"),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            postsListBLoC.posts[index].numDislikes++;
                            print(
                                "Number of Dislikes: ${postsListBLoC.posts[index].numDislikes}");
                          },
                          icon: const Icon(Icons.thumb_down_outlined,
                              size: 20),
                        ),
                        Text("  ${postsListBLoC.posts[index].numDislikes}"),
                      ],
                    ),
                  ],
                )),
          ),
        );
      }
  );
}
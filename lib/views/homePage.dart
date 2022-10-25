import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Post.dart';

List<Post> allPosts= [];

void initializeAllPosts(){
  allPosts= [
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        description: "Lambda calculus (also written as λ-calculus) is a formal system in mathematical logic for expressing computation based on function abstraction and application using variable binding and substitution. It is a universal model of computation that can be used to simulate any Turing machine.",
        imageURL: "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg",
        title: "Test Title MUST BE VERY LONG"),
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        description: "words words words words words words words words words words words words",
        imageURL: "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg",
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

  TextStyle defaultStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(widget.title!)),
      body: ListView.builder(
          itemCount: allPosts.length,
          padding: EdgeInsets.all(15),
          itemBuilder: (context, index){
            return Form(child:
                Container(
                    child: Column(
                      children: [
                        //Username and time of post
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  child: Text("AA", textScaleFactor: 1),
                                ),
                                SizedBox(width: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("${allPosts[index].userName}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(Icons.more_vert),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("${allPosts[index].timeString}",style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15)),
                          ],
                        ),
                        SizedBox(height: 10),

                        Text(
                          "${allPosts[index].title}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),

                        //Description
                        Text("${allPosts[index].description}", textAlign:TextAlign.justify, style: defaultStyle,),
                        SizedBox(height: 20),

                        //Image
                        Image.network("${allPosts[index].imageURL}"),                                                  //image section
                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                onPressed: (){},
                                icon: const Icon(Icons.chat_bubble_outline, size: 20,),
                            ),
                            Text("  ${allPosts[index].numComments}"),
                            const SizedBox(width: 20),

                            IconButton(
                              onPressed: (){
                                allPosts[index].numReposts++;
                                print("Number of Likes: ${allPosts[index].numReposts}");
                              },
                              icon: const Icon(Icons.repeat, size: 20),
                            ),
                            Text(" ${allPosts[index].numReposts}"),
                            const SizedBox(width: 20),

                            IconButton(
                              onPressed: (){
                                allPosts[index].numLikes++;
                                print("Number of Likes: ${allPosts[index].numLikes}");
                              },
                              icon: const Icon(Icons.thumb_up_outlined, size: 20),
                            ),
                            Text("  ${allPosts[index].numLikes}"),
                            const SizedBox(width: 20),

                            IconButton(
                              onPressed: (){
                                allPosts[index].numDislikes++;
                                print("Number of Dislikes: ${allPosts[index].numDislikes}");
                              },
                              icon: const Icon(Icons.thumb_down_outlined, size: 20),
                            ),
                            Text("  ${allPosts[index].numDislikes}"),

                          ],
                        ),
                        SizedBox(height: 30,),

                      ],
                    )
                )
            );
          }
      ),
    );
  }
}

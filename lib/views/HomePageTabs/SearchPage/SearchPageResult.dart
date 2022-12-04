import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../models/Account.dart';
import '../../../models/PostOnline.dart';
import '../../DatabaseEditors.dart';
import '../OfflineDatabase/OfflineHomeScreenBuilder.dart';

class SearchPageResult extends StatefulWidget {
  SearchPageResult({Key? key, this.user, this.loggedInUser}) : super(key: key);

  Account? user;
  Account? loggedInUser;

  @override
  State<SearchPageResult> createState() => _SearchPageResultState();
}

class _SearchPageResultState extends State<SearchPageResult> {
  final fireBaseInstance = FirebaseFirestore.instance.collection('posts');
  bool follow = true;

  @override
  Widget build(BuildContext context) {
      return StreamBuilder(
        stream: fireBaseInstance.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            print("Data is missing from buildGradeList");
            return CircularProgressIndicator();
          } else {

            List<dynamic> profilePosts = [];
            for (int i = 0; i < snapshot.data.docs.length; i++){
              PostOnline post = PostOnline.fromMap(snapshot.data.docs[i].data(), reference: snapshot.data.docs[i].reference);
              widget.user!.numposts = 0;
              if(post.userName?.toLowerCase() == widget.user!.userName!.toLowerCase()){
                profilePosts.add({"post": post, "id": i});
                widget.user!.numposts = widget.user!.numposts! + 1;
              }
            }

            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(
                          "${widget.user!.userName}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 1,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.teal,
                                  child: Text(widget.user!.userName![0] +
                                      widget.user!.userName![widget.user!.userName!.length - 1]),
                                )),
                            Flexible(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Text("${widget.user!.numposts} Posts" ),
                                    Text(" ${widget.user!.followers} Followers "),
                                    Text(" ${widget.user!.following} Following"),
                                  ],
                                )),

                          ],
                        ),
                        const SizedBox(height: 10),

                        ElevatedButton.icon(
                          onPressed: () async {
                            if (follow) {
                              setState(() {
                                widget.user!.followers = widget.user!.followers! + 1;
                                widget.loggedInUser!.following = widget.loggedInUser!.following! - 1;
                                follow = !follow;
                              });
                            }
                            else {
                              setState(() {
                                widget.user!.followers = widget.user!.followers! - 1;
                                widget.loggedInUser!.following = widget.loggedInUser!.following! - 1;
                                follow = !follow;
                              });
                            }
                          },
                          label: follow ? Text('Follow') : Text('Unfollow'),
                          icon: Icon(Icons.follow_the_signs, size: 24.0,),
                        ),
                        const SizedBox(height: 20),

                        //needs to be changed for only my posts

                        GridView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemCount: profilePosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = profilePosts[index]['id'];
                                    print(selectedIndex);
                                  });
                                },
                                onDoubleTap: () async {
                                  setState(() {
                                    selectedIndex = profilePosts[index]['id'];
                                    print(selectedIndex);
                                  });
                                  var updatedPost = await Navigator.pushNamed(
                                      context, '/commentPage',
                                      arguments: {'fireBaseInstance': fireBaseInstance
                                  });
                                  if(updatedPost != null) {
                                    updateOnlineDatabase(
                                        profilePosts[index]['id'], updatedPost,
                                        fireBaseInstance);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selectedIndex != profilePosts[index]['id']
                                          ? Colors.white
                                          : Colors.black12),
                                  padding: EdgeInsets.all(10),
                                  child: Image.network(
                                    "${profilePosts[index]['post'].imageURL}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            })
                      ]),
                ),
              ],
            );
          }
        });
  }
}
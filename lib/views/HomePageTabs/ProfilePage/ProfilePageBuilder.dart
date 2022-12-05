import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/Account.dart';
import '../../../models/PostOnline.dart';
import '../OfflineDatabase/OfflineHomeScreenBuilder.dart';
import '../../DatabaseEditors.dart';

class ProfilePageBuilder extends StatefulWidget {
  ProfilePageBuilder({Key? key, this.loggedInUser}) : super(key: key);

  Account? loggedInUser;

  @override
  State<ProfilePageBuilder> createState() => _ProfilePageBuilderState();
}

class _ProfilePageBuilderState extends State<ProfilePageBuilder> {
  final fireBaseInstance = FirebaseFirestore.instance.collection('posts');

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
              if(post.userName?.toLowerCase() == widget.loggedInUser!.userName!.toLowerCase()){
                profilePosts.add({"post": post, "id": i});
              }
            }

            print("Data Loaded!");
            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(
                          "${widget.loggedInUser!.userName}",
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
                                  backgroundColor: Colors.blue,
                                  child: Text(widget.loggedInUser!.userName![0] +
                                      widget.loggedInUser!.userName![widget.loggedInUser!.userName!.length - 1]),
                                )),
                            Flexible(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Text("${widget.loggedInUser!.numposts} Posts" ),
                                    Text(" ${widget.loggedInUser!.followers} Followers "),
                                    Text(" ${widget.loggedInUser!.following} Following"),
                                  ],
                                )),

                          ],
                        ),
                        const SizedBox(height: 10),

                        ElevatedButton.icon(
                          onPressed: () {}, //need to add page
                          icon: Icon(
                            // <-- Icon
                            Icons.edit,
                            size: 24.0,
                          ),
                          label: Text('edit profile'), // <-- Text
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

Future<void> goToCommentPage(context) async {
  var newPost = await Navigator.pushNamed(context, r'/commentPage');
}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groupproject/models/Post.dart';
import 'package:groupproject/views/HomePageTabs/CommentPage.dart';
import 'package:groupproject/views/HomePage.dart';
import 'package:groupproject/views/MakePostPage.dart';
import "package:provider/provider.dart";
void main() {
  runApp(
      MultiProvider(
        child: const MyApp(),
        providers: [
          ChangeNotifierProvider(create: (value) => PostsListBLoC()),
        ],
      )
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error initializing Firebase");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print("Succesfully connected to Firebase");
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const LoginPage(title: 'Flutter Demo Home Page'),
              routes: {
                '/homePage': (context) =>
                const HomePageWidget(title: "HomePage"),
                '/createPostPage': (context) =>
                const CreatePostWidget(title: "Create a Post"),
                '/commentPage': (context) => CommentPage()
              },
            );
          }
          else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: goToHomePage,
        tooltip: 'Login',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> goToHomePage() async{
    var loginStatus = await Navigator.pushNamed(context, r'/homePage');
  }

}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:groupproject/views/HomePageTabs/SearchPage/SearchPageResult.dart';
import '../../../models/Account.dart';
import 'package:http/http.dart' as http;

class SearchPage extends SearchDelegate {
  SearchPage({@required this.loggedInUser});
  final loggedInUser;

  Set<Account> Accounts = {};
  Set<String> Users = {};
  Set<String> searchTerms = {};

  Future<Set<String>> getsearchTerms() async {
    searchTerms.clear();

    var response = await http.get(Uri.parse('https://api.json-generator.com/templates/kxOSQepYhNiQ/data?access_token=2c20vp5dg2ugdoko5g1xodm0ib87mhoaykv9cn2c'));
    if (response.statusCode == 200) {
      print("made it here");
      List items = jsonDecode(response.body);
      for (var item in items) {
        print(item);
        Users.add(item['username']);
        Accounts.add(Account(userName: item['username'], password: item['password'],
        email: item['email'], numposts: 0, followers: item['followers'], following: item['following']));
      }
    }

    for (var account in Users) {
      if (!(loggedInUser.userName.toLowerCase == account)) {
        searchTerms.add(account);
      }
    }

    return searchTerms;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: getsearchTerms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var result = snapshot.data!.elementAt(index);
                return GestureDetector(onTap: () {
                  print("made it to result");
                },
                child: ListTile(
                  title: Text(result),
                ),
                );
              },
            );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: getsearchTerms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<String> matchQuery = [];
          for (var user in snapshot.data!) {
            if (user.toLowerCase().contains(query.toLowerCase())) {
              matchQuery.add(user);
            }
          }
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return GestureDetector(onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPageResult(
                              user: Accounts.elementAt(index),
                              loggedInUser: loggedInUser,
                    )
                    ));
              },
              child: ListTile(
                title: Text(result),
              ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      });
  }

}
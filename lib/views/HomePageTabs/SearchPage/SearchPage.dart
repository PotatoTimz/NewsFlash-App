import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../models/Account.dart';
import 'package:http/http.dart' as http;

class SearchPage extends SearchDelegate {
  SearchPage({@required this.loggedInUser});
  final loggedInUser;

  Set<String> Accounts = {};
  Set<String> searchTerms = {};

  Future<Set<String>> getsearchTerms() async {
    searchTerms.clear();

    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      Accounts = {};
      List items = jsonDecode(response.body);
      for (var item in items) {
        Accounts.add(item['username']);
      }
    }

    for (var account in Accounts) {
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
                return ListTile(
                  title: Text(result),
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
              return ListTile(
                title: Text(result),
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
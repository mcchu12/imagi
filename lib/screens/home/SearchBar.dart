import 'package:flutter/material.dart';

class SearchBar extends SearchDelegate<String> {
  List<String> recents = [];
  String searchFieldLabel = 'Photos';

  @override
  List<Widget> buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: recents.length,
      itemBuilder: (context, index) => ListTile(
            title: Text(recents[index]),
          ),
    );
  }
}

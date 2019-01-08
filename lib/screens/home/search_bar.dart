import 'package:flutter/material.dart';

import '../../widgets/image_grid.dart';

class SearchBar extends SearchDelegate<String> {
  List<String> recents = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (!recents.contains(query) && query != '') {
      recents.insert(0, query);
    }
    return Container(child: ImageGrid(option: 'SEARCH', query: query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: recents.length,
      itemBuilder: (context, index) => ListTile(
            title: Text(recents[index]),
            leading: Icon(Icons.history),
          ),
    );
  }
}

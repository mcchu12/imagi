import 'package:flutter/material.dart';

import './ImageGrid.dart';
import './SearchBar.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagi'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
          )
        ],
      ),
      body: Container(
          child: ImageGrid(
        term: 'trending',
      )),
    );
  }
}

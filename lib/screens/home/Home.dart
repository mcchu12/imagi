import 'package:flutter/material.dart';

import './ImageGrid.dart';
import './SearchBar.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        leading: Icon(Icons.menu),
        title: Text('Imagi'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
          )
        ],
      ),
      body: Container(child: ImageGrid()),
    );
  }
}

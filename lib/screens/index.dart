import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './home/index.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return MaterialApp(
      title: 'Imagi',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.white,
          accentColor: Colors.grey,
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
              title: TextStyle(color: Colors.grey),
              body2: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              )),
          iconTheme: IconThemeData(color: Colors.grey)),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

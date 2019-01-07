import 'package:flutter/material.dart';

import '../models/image_model.dart';

class ImageDetail extends StatelessWidget {
  final ImageModel image;
  ImageDetail(this.image);

  Widget _buildDetail(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(image.user['avatar']),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(image.user['name']),
                  Container(
                    // margin: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      '@${image.user['username']}',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          child: Hero(tag: image.id, child: Image.network(image.url)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            OutlineButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )),
                  Text('${image.likes}')
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Imagi'),
          centerTitle: true,
        ),
        body: Container(child: _buildDetail(context)));
  }
}

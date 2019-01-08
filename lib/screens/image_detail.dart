import 'package:flutter/material.dart';

import '../services/unsplash_api.dart';
import '../models/image_model.dart';

class ImageDetail extends StatefulWidget {
  final ImageModel image;
  ImageDetail(this.image);

  @override
  _ImageDetail createState() => _ImageDetail();
}

class _ImageDetail extends State<ImageDetail> {
  final UnsplashApi api = UnsplashApi();
  ImageModel image;
  List<ImageModel> moreImages;

  @override
  initState() {
    super.initState();
    image = widget.image;
    api.fetchImages('USER', image.user['username']).then((res) {
      setState(() {
        moreImages = res;
      });
    });
  }

  Widget _buildMoreImages() {
    if (moreImages == null) {
      return Container();
    }
    final List<Widget> images = [];
    for (var i in moreImages) {
      images.add(Container(child: Image.network(i.url)));
    }
    return Column(
      children: images,
    );
  }

  Widget _buildUser(BuildContext context) {
    return Padding(
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
                child: Text(
                  '@${image.user['username']}',
                  style: Theme.of(context).textTheme.body2,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    final roundedBorder =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          OutlineButton(
            onPressed: () {},
            shape: roundedBorder,
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: OutlineButton(
              onPressed: () {},
              shape: roundedBorder,
              child: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetail(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildUser(context),
        Container(
          child: Hero(tag: image.id, child: Image.network(image.url)),
        ),
        _buildButtons(context),
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

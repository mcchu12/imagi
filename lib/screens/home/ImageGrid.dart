import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:http/http.dart' as http;

import '../../models/ImageModel.dart';

class ImageGrid extends StatefulWidget {
  final String term;

  ImageGrid({this.term});

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  String kClientId =
      'c5dfe49f51dd47b5ed7e569545dabd230105787e83126dccf6caa78121af7769';

  List<ImageModel> images;
  int pageIndex = 1;
  ScrollController controller;
  bool isFetching = false;

  @override
  initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);

    fetchImages(pageIndex).then((res) {
      setState(() {
        images = [null]..addAll(res);
      });
      pageIndex += 1;
    });
  }

  Future<List<ImageModel>> fetchImages(int pageIndex) async {
    final res = await http.get(
      'https://api.unsplash.com/photos?page=$pageIndex',
      headers: {HttpHeaders.authorizationHeader: 'Client-ID $kClientId'},
    );

    final images = json.decode(res.body);
    return images
        .map<ImageModel>((image) => ImageModel.fromJson(image))
        .toList();
  }

  Widget _buildImage(int index) {
    ImageModel image = images[index];
    return FadeInImage(
      image: NetworkImage(image.url),
      fit: BoxFit.cover,
      placeholder: AssetImage('assets/wallfy.png'),
    );
  }

  Widget _buildImageGrid() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) =>
          index == 0 ? Text('Trending') : Container(child: _buildImage(index)),
      staggeredTileBuilder: (int index) => index == 0
          ? StaggeredTile.count(4, 1)
          : StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: const EdgeInsets.only(top: 10.0),
      controller: controller,
    );
  }

  void _scrollListener() {
    // print('extendAfter: ${controller.position.extentAfter}');
    final extendAfter = controller.position.extentAfter;
    if (!isFetching && extendAfter < 500) {
      isFetching = true;
      print(pageIndex);
      print(images.length);
      fetchImages(pageIndex).then((res) {
        setState(() {
          images = images..addAll(res);
        });
        pageIndex += 1;
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return images != null
        ? _buildImageGrid()
        : Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/ImageModel.dart';
import '../services/unsplash_api.dart';

class ImageGrid extends StatefulWidget {
  final String term;

  ImageGrid({this.term});

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  final UnsplashApi api = UnsplashApi();
  List<ImageModel> images;
  ScrollController controller;
  bool isFetching = false;

  @override
  initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);

    api.fetchImages(widget.term).then((res) {
      setState(() {
        images = res;
      });
    });
  }

  Widget _buildImage(int index) {
    ImageModel image = images[index];
    const roundedBorder = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)));
    return Card(
        elevation: 3.0,
        shape: roundedBorder,
        child: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: NetworkImage(image.url),
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/wallfy.png'),
            ),
          ),
          onTap: () {},
          customBorder: roundedBorder,
        ));
  }

  Widget _buildImageGrid() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) =>
          Container(child: _buildImage(index)),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: const EdgeInsets.only(top: 10.0),
      controller: controller,
    );
  }

  void _scrollListener() {
    final extendAfter = controller.position.extentAfter;
    if (!isFetching && extendAfter < 500) {
      isFetching = true;
      api.fetchImages(widget.term).then((res) {
        setState(() {
          images = images..addAll(res);
        });
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

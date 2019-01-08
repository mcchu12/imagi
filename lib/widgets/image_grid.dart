import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/image_model.dart';
import '../services/unsplash_api.dart';

import '../screens/image_detail.dart';

class ImageGrid extends StatefulWidget {
  final String option;
  final String query;

  ImageGrid({this.option, this.query});

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

    api.fetchImages(widget.option, widget.query).then((res) {
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
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondAnimation) {
                        return ImageDetail(images[index]);
                      },
                      transitionsBuilder:
                          (context, animation, secondAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500)));
            },
            child: Hero(
              tag: image.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: NetworkImage(image.url),
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/wallfy.png'),
                ),
              ),
            )));
  }

  Widget _buildImageGrid() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) =>
          Container(child: _buildImage(index)),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, images[index].portrait ? 3 : 2),
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
      api.fetchImages(widget.option, widget.query).then((res) {
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

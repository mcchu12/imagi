import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/ImageModel.dart';

class UnsplashApi {
  final String kClientId =
      'c5dfe49f51dd47b5ed7e569545dabd230105787e83126dccf6caa78121af7769';
  final String url = 'api.unsplash.com';

  int pageIndex = 1;

  Uri _getUrl(String term) {
    final page = pageIndex.toString();
    if (term == null) {
      return Uri.https(url, '/photos', {'page': page});
    }
    return Uri.https(url, '/search/photos', {'page': page, 'query': term});
  }

  Future<List<ImageModel>> fetchImages(String term) async {
    final res = await http.get(
      _getUrl(term),
      headers: {HttpHeaders.authorizationHeader: 'Client-ID $kClientId'},
    );

    if (res.statusCode == 200) {
      pageIndex += 1;
      final images = term == null
          ? json.decode(res.body)
          : json.decode(res.body)['results'];
      return images
          .map<ImageModel>((image) => ImageModel.fromJson(image))
          .toList();
    }
    return null;
  }
}

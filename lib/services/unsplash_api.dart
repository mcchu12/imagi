import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/image_model.dart';

class UnsplashApi {
  final String kClientId =
      'c5dfe49f51dd47b5ed7e569545dabd230105787e83126dccf6caa78121af7769';
  final String url = 'api.unsplash.com';

  int pageIndex = 1;

  Uri _getUrl(String option, String query) {
    final page = pageIndex.toString();
    switch (option) {
      case 'SEARCH':
        return Uri.https(url, '/search/photos', {'page': page, 'query': query});
      case 'USER':
        return Uri.https(url, '/users/$query/photos', {'page': page});
      default:
        return Uri.https(url, '/photos', {'page': page});
    }
  }

  Future<List<ImageModel>> fetchImages(String option, String query) async {
    final res = await http.get(
      _getUrl(option, query),
      headers: {HttpHeaders.authorizationHeader: 'Client-ID $kClientId'},
    );

    if (res.statusCode == 200) {
      pageIndex += 1;
      final images = option == 'SEARCH'
          ? json.decode(res.body)['results']
          : json.decode(res.body);
      return images
          .map<ImageModel>((image) => ImageModel.fromJson(image))
          .toList();
    }
    return null;
  }
}

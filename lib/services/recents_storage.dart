import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class RecentStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/recents.txt');
  }

  Future<List<String>> readRecents() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();

      return json.decode(contents);
    } catch (e) {
      return [];
    }
  }

  Future<File> writeRecent(String recent) async {
    final file = await _localFile;

    return file.writeAsString(recent);
  }
}

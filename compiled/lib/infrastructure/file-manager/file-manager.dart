import 'dart:convert';

import 'package:flutter/services.dart';

class FileManager {
  final Map<String, dynamic> cache = {};

  Future<List<dynamic>> jsonFileToMapList(String path) async {
    if (cache[path] != null) {
      return cache[path];
    }

    String data = await rootBundle.loadString(path);
    List<dynamic> jsonResult = json.decode(data);

    cache[path] = jsonResult;
    return jsonResult;
  }

  Future<void> addToJsonMapList(Map<String, dynamic> object, String path) {
    var temp = (cache[path] as List).reversed.toList();
    temp.add(object);
    cache[path] = temp.reversed.toList();

    return null;
  }
}

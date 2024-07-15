import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


  const FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> saveSearchHistory(List<String> list) async {
    String jsonString = jsonEncode(list);
    await storage.write(key: "search", value: jsonString);
  }

  Future<List<String>> getSearchHistory() async {
    String? jsonString = await storage.read(key: "search");
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => e as String).toList();
    }
    return [];
  }




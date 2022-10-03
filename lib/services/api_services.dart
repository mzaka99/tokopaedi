import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl =
    'tokopaedi-33fb6-default-rtdb.asia-southeast1.firebasedatabase.app';

class APIServices {
  // Future<void> authenicate(){}

  dynamic getData({
    required String path,
    Map<String, dynamic>? params,
  }) async {
    final url = Uri.https(baseUrl, path, params);
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      rethrow;
    }
  }
}

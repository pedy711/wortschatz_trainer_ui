import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'constants.dart';

class HttpHelper {
  static final HttpHelper _httpHelper = HttpHelper._internal();
  static const jasonCodec = const JsonCodec();

  HttpHelper._internal();

  factory HttpHelper(){
    return _httpHelper;
  }

  Future<Response> post(String body, String path) async {
    Uri uri = Uri.http(Constants.SERVER_URL, path);

    http.Response response = await http.post(
        uri,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        }
    );

    return response;
  }


}
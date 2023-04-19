import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/repositories/api/app_api.dart';
import 'package:http/http.dart' as http;

abstract class AppClient {
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  });
}

class AppClientHttp implements AppClient {
  @override
  Future<Map<String, dynamic>> get(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? params}) async {
    final uri = Uri.parse(url).replace(queryParameters: params);
    final _headers = {HttpHeaders.authorizationHeader: AppApi.token};
    if (headers != null) _headers.addAll(headers);
    try {
      debugPrint(
          "============================================================= Call API =============================================================");
      debugPrint("URL: $url");
      debugPrint("HEADER: $_headers");
      debugPrint("PARAMS: $params");
      debugPrint("BODY: $body");
      final response = await http.get(uri, headers: _headers);
      if (response.statusCode == HttpStatus.ok) {
        debugPrint("Call API Successfully!!!!!!!!!");
        debugPrint("Data: ${jsonDecode(response.body)}");
        debugPrint(
            "=============================================================END=============================================================");
        return jsonDecode(response.body);
      } else {
        debugPrint(
            "=============================================================Error=============================================================");
        throw Exception("Status Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

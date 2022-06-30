import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class FixingDio {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl:
      'http://10.0.2.2:5000/',
      receiveDataWhenStatusError: true,
      connectTimeout: 4000,
      receiveTimeout: 3000,

    ));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
    client.badCertificateCallback =
    (X509Certificate cert, String host, int port) => true;
    return client;
    };
  }

  static Future<Response> getFixed(
      {@required String url, @required Map<String, dynamic> query}) async {

    return await dio.get(url, queryParameters: query);
  }



}

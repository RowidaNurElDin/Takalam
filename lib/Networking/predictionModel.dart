import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class PredictionDio {
  static Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl:
      'https://api-inference.huggingface.co/',
      receiveDataWhenStatusError: true,
      connectTimeout: 4000,
      receiveTimeout: 3000,

    ));
    dio.options.headers["Authorization"] = "Bearer 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";
  }

  static Future<Response> getData(
      {@required String url, @required Map<String, dynamic> query}) async {

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {@required String url, @required Map<String, String> body}) async {
    return await dio.post(url, data: body);
  }





  static Future<Response> getTrial(
      {
        @required String url ,
        @required Map<String,dynamic> query})async
  {
    return await dio.get(url, queryParameters: query);
  }

}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static Dio dio;

  static init({String baseURL}){
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,

      ),

    );
  }

  static Future<Response> getData({
    @required String url,
    @required Map query,
  }) async {

    return await dio.get(url, queryParameters: query);

  }
}
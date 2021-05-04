import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    Map<String, dynamic> specialOptions,
    String token,
  }) async {
    dio.options.headers = specialOptions != null
        ? specialOptions
        : {
            'lang': 'en',
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': token,
          };
    return await dio.get(
      url,
      queryParameters: query != null ? query : null,
    );
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> specialOptions,
    String token,
  }) async {
    dio.options.headers = specialOptions != null
        ? specialOptions
        : {
            'lang': 'ar',
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': token,
          };
    return await dio.post(
      url,
      data: data,
    );
  }

  static Future<Response> updateData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> specialOptions,
    String token,
  }) async {
    dio.options.headers = specialOptions != null
        ? specialOptions
        : {
            'lang': 'ar',
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': token,
          };
    return await dio.put(
      url,
      data: data,
    );
  }

  static Future<Response> deleteData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> specialOptions,
    String token,
  }) async {
    dio.options.headers = specialOptions != null
        ? specialOptions
        : {
            'lang': 'ar',
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': token,
          };
    return await dio.delete(
      url,
      data: data,
    );
  }
}

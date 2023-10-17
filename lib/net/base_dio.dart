import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../common/dialogues.dart';

class BaseDio {
  BaseDio._();

  static BaseDio _instance = BaseDio._();

  static BaseDio getInstance() {
    _instance = BaseDio._();

    return _instance;
  }

  Dio getDio() {
    final Dio dio = Dio();
    dio.options = BaseOptions(
      receiveTimeout: 66000,
      connectTimeout: 66000,
    );
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
    }));
    dio.options.headers = {};

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
    return dio;
  }

  static void getDioError(Object obj) {
    switch (obj.runtimeType) {
      case DioError:
        if ((obj as DioError).type == DioErrorType.response) {
          final response = (obj).response;
          if (response!.statusCode == 401) {
            showAlertDialog(
                error: "No active account found with the given credentials",
                errorType: "Authentication Error");
          } else if (response.statusCode == 404) {
            showAlertDialog(
                error: "There is no Account against this Email",
                errorType: "Invalid Email");
          }
          if (response.statusCode == 422) {
            showAlertDialog(error: "This is 422 error", errorType: "DioError");
          }
          if (response.statusCode == 400) {
            showAlertDialog(error: "This is 400 error", errorType: "DioError");
          }
          if (response.statusCode == 500) {
            showAlertDialog(
                error: "${response.data.toString()}", errorType: "DioError");
          }
        } else if ((obj).type == DioErrorType.other) {}
    }
  }
}

import 'package:dio/dio.dart';

class DioUtils {
  // 请求基地址
  final baseUrl = "http://192.168.31.118:8080";

  Dio dio = Dio();

  Future<dynamic> get(String path, ResponseType type,
      {Map<String, dynamic> params = const {}}) async {
    Options option = Options(
      responseType: type,
    );
    final url = "$baseUrl$path";
    try {
      Response response =
          await dio.get(url, queryParameters: params, options: option);
      return response.data;
    } catch (exception) {
      print("Exception: $exception");
    }
  }

  Future<dynamic> post(String path, ResponseType type,
      {Map<String, dynamic> params = const {}}) async {
    Options option = Options(
      contentType: Headers.jsonContentType,
      responseType: type,
    );
    final url = "$baseUrl$path";
    try {
      Response response =
          await dio.post(url, queryParameters: params, options: option);
          print(response.statusCode);
      return response.data;
    } catch (exception) {
      print("Exception: $exception");
    }
  }

  String getFullUrl(String path) {
    return "$baseUrl$path";
  }

  void cancelRequests() {
    dio.close(force: true);
  }
}

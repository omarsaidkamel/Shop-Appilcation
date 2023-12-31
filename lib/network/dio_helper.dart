import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {'Content-Type': 'application/json', 'lang': 'en'}),
    );
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'lang': 'en',
          'Authorization': token,
        },
      ),
    );
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token}) async {
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'lang': 'en',
          'Authorization': token,
        },
      ),
    );
  }
}

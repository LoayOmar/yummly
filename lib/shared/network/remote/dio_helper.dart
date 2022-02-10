import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://themealdb.p.rapidapi.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
  }) async {
    dio.options.headers = {
      'x-rapidapi-key' : 'a24ed8dd8bmshc9f6406bada00a0p14170fjsnf4f89569b873'
    };

    return await dio.get(
      url,
    );
  }

  static late Dio sideDio;

  static sideInit() {
    sideDio = Dio(
      BaseOptions(
        baseUrl: 'https://webknox-recipes.p.rapidapi.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getSideData({
    required String url,
  }) async {
    sideDio.options.headers = {
      'x-rapidapi-key' : 'a24ed8dd8bmshc9f6406bada00a0p14170fjsnf4f89569b873',
    };

    return await sideDio.get(
      url,
    );
  }
}

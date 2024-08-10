import 'package:dio/dio.dart';


//    https://www.getpostman.com/collections/94db931dc503afd508a5


class DioHelper
{
  static Dio dio = Dio();
  // static late Dio dio;
  static void init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String ,dynamic> ? query,
    String ? lang='en',
    String ? token,
})async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token

    };
    return await dio.get(url,queryParameters: query);
  }


  static Future<Response> postData({
    required String url,
    Map<String ,dynamic>? query,
    required Map<String ,dynamic> data,
    String ? lang='en',
    String ? token,
  })async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token

    };
    return dio.post(
        url,
        queryParameters: query,
        data: data

    );
  }






  static Future<Response> putData({
    required String url,
    Map<String ,dynamic>? query,
    required Map<String ,dynamic> data,
    String ? lang='en',
    String ? token,
  })async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token

    };
    return dio.put(
        url,
        queryParameters: query,
        data:data
    );
  }




  static Future<Response> deleteData({
    required String url,
    Map<String ,dynamic>? query,
    Map<String ,dynamic> ?data,
    String ? lang='en',
    String ? token,
  })async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token

    };
    return dio.delete(
        url,
        queryParameters: query,
    );
  }




}
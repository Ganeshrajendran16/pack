import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

BaseOptions options;
String url = "https://admin.awomowa.com/api/web/v1/"; //live
// String url = "https://dev.hirephpcoder.com/awomowa/api/web/v1/"; //dev

Dio getDio({String key}) {
  print(key);
  options = BaseOptions(
      baseUrl: url,
      connectTimeout: 100000,
      receiveTimeout: 100000,
      headers: {
        //"Connection": "Keep-Alive",
        //  "Authorization": 'cES26KExSAnUhXYapjr9BVCaOTjTv24a',
        "Authorization": key,
      });

  Dio dio = Dio(options);
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    request: true,
    compact: true,
  ));
  return dio;
}

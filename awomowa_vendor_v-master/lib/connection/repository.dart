import 'dart:convert';

import 'package:awomowa_vendor/connection/connection.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:dio/dio.dart';

Future<dynamic> loadApi({var params, String apiUrl, Function onError}) async {
  SharedPrefManager prefManger = SharedPrefManager();
  Response response;
  Map<String, dynamic> parsed;

  try {
    response = await getDio(key: await prefManger.getAuthKey())
        .post(apiUrl, data: params);
    parsed = json.decode(response.data);
  } on DioError catch (e) {
    print(e.message);
    onError(e.message);
    print('error');
    return null;
  }

  return parsed;
}

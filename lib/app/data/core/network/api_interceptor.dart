import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';

import '../local/shared_pref.dart';

class ApiInterceptor extends Interceptor {
  late SharedPreferencesManager sharedPreferencesManager;

  ApiInterceptor({
    required this.sharedPreferencesManager,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data != null || options.data is! FormData) {
      Get.log("Body: ${jsonEncode(options.data)}, Path: ${options.path}");
    }

    final accessToken = sharedPreferencesManager.getString(SharedPreferencesManager.keyAccessToken);
    if (accessToken != null) {
      options.headers.addAll({"Authorization": "Bearer $accessToken", "Accept": "application/json"});
    } else {
      options.headers.addAll({"Accept": "application/json"});
    }
    Get.log('Header: ${options.headers}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      response.data = jsonDecode(response.data);
    } on FormatException {
      response.data = response.data;
    }

    Get.log("Response: ${response.statusCode} ${response.realUri}");
    Get.log(const JsonEncoder.withIndent('  ').convert(response.data));
    Get.log("<-- END HTTP RESPONSE -->");
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // err.response?.data = jsonDecode(err.response?.data);
    Get.log(
        "<-- ${err.message} ${(err.response != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
    Get.log("${err.response != null ? err.response!.data : 'Unknown Error'}");
    Get.log("<-- End error");
    if (err.response?.statusCode == 403) {
      // Refresh token function here
      return handler.next(err);
    } else {
      return handler.next(err);
    }
  }
}

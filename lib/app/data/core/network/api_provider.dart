import 'package:dio/dio.dart';
import 'package:manga_track_app/app/data/core/network/api_interceptor.dart';

abstract class ApiProvider {
  Future<Response> getMangaGenres();
  Future<Response> getManga(String? query, int? genreId, {int page = 1, int limit = 25});
}

class ApiProviderImpl implements ApiProvider {
  final Dio _dio = Dio(options);

  ApiProviderImpl(ApiInterceptor apiInterceptor) {
    _dio.interceptors.add(apiInterceptor);
  }

  static BaseOptions options = BaseOptions(
    baseUrl: "https://api.jikan.moe/v4",
    contentType: "application/json",
    followRedirects: true,
    responseType: ResponseType.plain,
    connectTimeout: const Duration(milliseconds: 60000),
    receiveTimeout: const Duration(milliseconds: 60000),
    validateStatus: (status) {
      return status! < 500;
    },
  );

  @override
  Future<Response> getMangaGenres() {
    return _dio.get("/genres/manga");
  }

  @override
  Future<Response> getManga(String? query, int? genreId, {int page = 1, int limit = 25}) {
    return _dio.get("/manga", queryParameters: {
      'page': page.toString(),
      'limit': limit.toString(),
      'sfw': 'true',
      'genres_exclude': "12,49,28,9,22",
      if (query != null && query.isNotEmpty) 'q': query,
      if (genreId != null) 'genres': genreId.toString(),
    });
  }
}

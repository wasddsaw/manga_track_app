import 'package:dio/dio.dart';
import 'package:manga_track_app/app/data/core/network/api_provider.dart';

abstract class MangaRemoteDataSource {
  Future<Response> getMangaGenres();
  Future<Response> getManga(String? query, int? genreId, {int page = 1, int limit = 25});
}

class MangaRemoteDataSourceImpl implements MangaRemoteDataSource {
  final ApiProvider apiProvider;

  MangaRemoteDataSourceImpl({required this.apiProvider});

  @override
  Future<Response> getMangaGenres() {
    return apiProvider.getMangaGenres();
  }

  @override
  Future<Response> getManga(String? query, int? genreId, {int page = 1, int limit = 25}) {
    return apiProvider.getManga(query, genreId, page: page, limit: limit);
  }
}

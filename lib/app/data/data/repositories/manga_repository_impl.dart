import 'package:manga_track_app/app/data/data/datasources/manga/manga_remote_data_source.dart';
import 'package:manga_track_app/app/data/domain/repositories/manga_repository.dart';
import 'package:dio/dio.dart';

class MangaRepositoryImpl implements MangaRepository {
  final MangaRemoteDataSource remoteDataSource;

  MangaRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<void> getMangaGenres() async {
    try {
      final response = await remoteDataSource.getMangaGenres();
      if (response.statusCode == 200) {
        return response.data;
      }
      throw response;
    } on DioException catch (err) {
      return Future.error(err);
    }
  }

  @override
  Future<void> getManga(String? query, int? genreId, {int page = 1, int limit = 25}) async {
    try {
      final response = await remoteDataSource.getManga(query, genreId, page: page, limit: limit);
      if (response.statusCode == 200) {
        return response.data;
      }
      throw response;
    } on DioException catch (err) {
      return Future.error(err);
    }
  }
}

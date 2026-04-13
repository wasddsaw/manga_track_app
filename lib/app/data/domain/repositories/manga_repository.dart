abstract class MangaRepository {
  Future getMangaGenres();
  Future getManga(String? query, int? genreId, {int page = 1, int limit = 25});
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_track_app/app/data/domain/repositories/manga_repository.dart';
import 'package:manga_track_app/app/services/utils/common.dart';
import 'package:dio/dio.dart' as dio;

class DiscoverController extends GetxController {
  late MangaRepository mangaRepository;

  DiscoverController({
    required this.mangaRepository,
  });

  List<Map<String, dynamic>> kSampleGenres = [
    {'mal_id': 1, 'name': 'Action'},
    {'mal_id': 2, 'name': 'Adventure'},
    {'mal_id': 4, 'name': 'Comedy'},
    {'mal_id': 8, 'name': 'Drama'},
    {'mal_id': 10, 'name': 'Fantasy'},
    {'mal_id': 14, 'name': 'Horror'},
    {'mal_id': 22, 'name': 'Romance'},
    {'mal_id': 36, 'name': 'Slice of Life'},
  ];

  RxList<Map<String, dynamic>> genres = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> mangaList = <Map<String, dynamic>>[].obs;

  RxInt selectedGenreId = 0.obs;
  RxString searchQuery = ''.obs;

  RxSet<int> favouriteIds = <int>{}.obs;

  int page = 1;
  bool isLoadingMore = false;
  bool hasMore = true;
  bool isError = false;

  int totalFetched = 0;
  int maxTotal = 60;
  int maxPages = 3;

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        if (isLoadingMore || !hasMore) return;
        loadMore();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();

    init();
  }

  Future<void> init() async {
    await getMangaGenres();
    await getManga(null, null, limit: 20);
  }

  loadMore() {
    getManga(searchQuery.value, selectedGenreId.value, loadMore: true);
  }

  Future<void> getMangaGenres() async {
    OverlayUtils.showLoading();
    try {
      final response = await mangaRepository.getMangaGenres();
      genres.value = List<Map<String, dynamic>>.from(response['data']);
    } catch (e) {
      if (e is dio.Response) {
        OverlayUtils.closeLoading();
        OverlayUtils.showSnackbar(message: e.data['message']);
        return;
      }

      OverlayUtils.closeLoading();
      OverlayUtils.showWarningDialog('Unexpected error', '$e', () => Get.back());
      return;
    }
    OverlayUtils.closeLoading();
  }

  Future<void> getManga(String? query, int? genreId, {bool loadMore = false, int limit = 25}) async {
    if (isLoadingMore) return;

    // First load vs pagination
    if (loadMore) {
      if (!hasMore) return;

      if (page >= maxPages || totalFetched >= maxTotal) {
        hasMore = false;
        update();
        return;
      }
    } else {
      // reset state for new search/filter
      page = 1;
      totalFetched = 0;
      mangaList.clear();
      hasMore = true;
    }

    isLoadingMore = true;

    // Only show full loader on first load
    if (!loadMore && searchQuery.value.isEmpty) {
      OverlayUtils.showLoading();
    }

    try {
      final response = await mangaRepository.getManga(query, genreId, page: page, limit: limit);
      final List<Map<String, dynamic>> newData = List<Map<String, dynamic>>.from(response['data'] ?? []);

      mangaList.addAll(newData);
      totalFetched += newData.length;
      page++;

      // Stop conditions
      if (page > maxPages || totalFetched >= maxTotal) {
        hasMore = false;
      }
    } catch (e) {
      isError = true;

      if (e is dio.DioException) {
        final statusCode = e.response?.statusCode;

        OverlayUtils.closeLoading();

        if (statusCode == 504) {
          OverlayUtils.showSnackbar(message: "Server timeout. Please try again.");
        } else {
          OverlayUtils.showSnackbar(message: e.response?.data?['message'] ?? "Request failed");
        }
      } else {
        OverlayUtils.showWarningDialog('Unexpected error', '$e', () => Get.back());
      }

      return;
    } finally {
      isLoadingMore = false;
      if (!isError) OverlayUtils.closeLoading();
      update();
    }
  }

  onGenreChanged(int? genreId) {
    selectedGenreId.value = genreId ?? 0;
    getManga(
      searchQuery.value.isEmpty ? null : searchQuery.value,
      selectedGenreId.value == 0 ? null : selectedGenreId.value,
    );
  }

  onSearchChanged(String query) {
    searchQuery.value = query;

    page = 1;
    totalFetched = 0;
    hasMore = true;

    mangaList.clear();

    getManga(
      searchQuery.value.isEmpty ? null : searchQuery.value,
      selectedGenreId.value == 0 ? null : selectedGenreId.value,
    );
  }

  toggleFavourite(int id) {
    if (favouriteIds.contains(id)) {
      favouriteIds.remove(id);
    } else {
      favouriteIds.add(id);
    }
  }

  List<Map<String, dynamic>> get favouriteManga {
    return mangaList.where((m) => favouriteIds.contains(m['mal_id'])).toList();
  }
}

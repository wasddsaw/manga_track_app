import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_track_app/app/modules/discover/controllers/discover_controller.dart';

class BrowseController extends GetxController {
  final ScrollController scrollController = ScrollController();

  // RxInt activeGenreIndex = 0.obs;

  int activeGenreIndex = 0;

  Map<String, GlobalKey> sectionKeys = {};

  RxList<String> genres = <String>[].obs;
  Map<String, List<dynamic>> grouped = {};

  @override
  void onInit() {
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  Future<void> onReload() async {
    Get.log('BrowseController onReload called');
    final discoverController = Get.find<DiscoverController>();
    initData(discoverController.mangaList);
  }

  void initData(List<dynamic> mangaList) {
    Get.log('initData called with mangaList length: ${mangaList.length}');

    final Map<String, List<dynamic>> temp = {};

    for (var manga in mangaList) {
      final genres = manga['genres'] as List;

      for (var genre in genres) {
        final genreName = genre['name'];

        temp.putIfAbsent(genreName, () => []);
        temp[genreName]!.add(manga);
      }
    }

    grouped = temp..removeWhere((key, value) => value.isEmpty);

    genres.value = grouped.keys.toList();

    sectionKeys = {for (final g in genres) g: GlobalKey()};
  }

  // void initData(List<dynamic> mangaList) {
  //   Get.log('initData called with mangaList length: ${mangaList.length}');
  //   final Map<String, List<dynamic>> temp = {};

  //   for (var manga in mangaList) {
  //     final genres = manga['genres'] as List;

  //     for (var genre in genres) {
  //       final genreName = genre['name'];

  //       temp.putIfAbsent(genreName, () => []);
  //       temp[genreName]!.add(manga);
  //     }
  //   }

  //   grouped = temp..removeWhere((key, value) => value.isEmpty);
  //   genres.value = grouped.keys.toList();

  //   sectionKeys.clear();

  //   for (var genre in genres) {
  //     sectionKeys[genre] = GlobalKey();
  //   }

  //   scrollController.addListener(_onScroll);
  // }

  void scrollToGenre(int index) {
    if (index < 0 || index >= genres.length) {
      Get.log('Invalid index: $index');
      return;
    }

    if (activeGenreIndex == index) {
      Get.log('Same index tapped, ignore scroll');
      return;
    }

    final genre = genres[index];
    final key = sectionKeys[genre];

    final context = key?.currentContext;
    if (context == null) {
      Get.log('No context found for genre: $genre');
      return;
    }

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.0,
    );

    activeGenreIndex = index;
    update();
  }

  void _onScroll() {
    for (int i = 0; i < genres.length; i++) {
      final key = sectionKeys[genres[i]];
      final context = key?.currentContext;

      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);

        if (position.dy <= 150 && position.dy >= 0) {
          activeGenreIndex = i;
          update();
          break;
        }
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

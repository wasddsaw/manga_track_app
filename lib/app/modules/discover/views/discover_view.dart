import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_track_app/app/modules/discover/views/image_view.dart';

import '../controllers/discover_controller.dart';

class DiscoverView extends GetView<DiscoverController> {
  const DiscoverView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DiscoverController(mangaRepository: Get.find()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('DiscoverView'),
        centerTitle: true,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Search manga...', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
                onChanged: controller.onSearchChanged,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('All'),
                        selected: controller.selectedGenreId.value == 0,
                        onSelected: (_) => controller.onGenreChanged(null),
                      ),
                    ),
                    ...(controller.genres.isNotEmpty ? controller.genres : controller.kSampleGenres).map((g) {
                      final id = g['mal_id'] as int;
                      final name = g['name'] as String;

                      final isSelected = controller.selectedGenreId.value == id;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(name),
                          selected: isSelected,
                          onSelected: (_) => controller.onGenreChanged(isSelected ? null : id),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Obx(() {
                  final list = controller.mangaList;

                  if (list.isEmpty && controller.searchQuery.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_book, size: 64, color: Colors.grey),
                          SizedBox(height: 12),
                          Text('No manga available', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: list.length + 1,
                    itemBuilder: (context, index) {
                      if (index == list.length) {
                        if (controller.isLoadingMore) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (!controller.hasMore) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                "You've reached the end",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      }

                      final manga = list[index];
                      // final id = manga['mal_id'];
                      final title = manga['title'] ?? 'No Title';
                      final image = manga['images']?['jpg']?['image_url'] ?? '';
                      // final isFav = controller.favouriteIds.contains(id);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: image.isNotEmpty
                                ? Image.network(
                                    image,
                                    width: 60,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return const SizedBox(
                                        width: 60,
                                        height: 80,
                                        child: Center(
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                      );
                                    },
                                  )
                                : const Icon(Icons.image, size: 40),
                          ),
                          title: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: Obx(() {
                            final isFav = controller.favouriteIds.contains(manga['mal_id']);
                            return IconButton(
                              icon: Icon(
                                isFav ? Icons.bookmark : Icons.bookmark_border,
                                color: isFav ? Colors.indigo : null,
                              ),
                              onPressed: () {
                                controller.toggleFavourite(manga['mal_id']);
                              },
                            );
                          }),
                          onTap: () {
                            Get.to(() => const ImageViewerScreen(imageUrl: 'https://picsum.photos/id/25/600/3000'));
                          },
                        ),
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

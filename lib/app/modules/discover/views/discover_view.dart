import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_track_app/app/modules/discover/views/image_view.dart';
import 'package:manga_track_app/app/services/components/shared/shared.dart';
import 'package:manga_track_app/app/services/utils/common.dart';
import 'package:manga_track_app/app/services/utils/global_style.dart';

import '../controllers/discover_controller.dart';

class DiscoverView extends GetView<DiscoverController> {
  const DiscoverView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DiscoverController(mangaRepository: Get.find()));
    return Scaffold(
      appBar: const CustomAppBar('MangaTrack', titleTextSize: 1.6),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Discover',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: gFontSize * 2.1,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: '\nStories',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: gFontSize * 2.1,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primary2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Curated updates from the world\'s most\nimmersive visual narratives.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: gFontSize * 1.2,
                  fontWeight: FontWeight.w500,
                  color: AppColors.inverted,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                cursorColor: AppColors.primary,
                style: const TextStyle(color: AppColors.textSecondary),
                decoration: InputDecoration(
                  fillColor: AppColors.background2,
                  filled: true,
                  hintText: 'Search for titles, authors, or tags...',
                  hintStyle:
                      TextStyle(fontSize: gFontSize * 1.2, fontWeight: FontWeight.w400, color: AppColors.inverted),
                  prefixIcon: const Icon(Icons.search, color: AppColors.primary2),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(56)),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(56)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(56)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: controller.onSearchChanged,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        showCheckmark: false,
                        label: const Text('All'),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                        labelStyle: TextStyle(
                            color: controller.selectedGenreId.value == 0 ? AppColors.text : AppColors.inverted),
                        selectedColor: AppColors.primary2,
                        backgroundColor: AppColors.background2,
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
                          showCheckmark: false,
                          label: Text(name),
                          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                          labelStyle: TextStyle(color: isSelected ? AppColors.text : AppColors.inverted),
                          selectedColor: AppColors.primary2,
                          backgroundColor: AppColors.background2,
                          selected: isSelected,
                          onSelected: (_) => controller.onGenreChanged(isSelected ? null : id),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      // body: Obx(
      //   () => Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         const SizedBox(height: 8),
      //         TextField(
      //           decoration: const InputDecoration(
      //               labelText: 'Search manga...', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
      //           onChanged: controller.onSearchChanged,
      //         ),
      //         const SizedBox(height: 8),
      //         SizedBox(
      //           height: 40,
      //           child: ListView(
      //             scrollDirection: Axis.horizontal,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 8),
      //                 child: FilterChip(
      //                   label: const Text('All'),
      //                   selected: controller.selectedGenreId.value == 0,
      //                   onSelected: (_) => controller.onGenreChanged(null),
      //                 ),
      //               ),
      //               ...(controller.genres.isNotEmpty ? controller.genres : controller.kSampleGenres).map((g) {
      //                 final id = g['mal_id'] as int;
      //                 final name = g['name'] as String;

      //                 final isSelected = controller.selectedGenreId.value == id;

      //                 return Padding(
      //                   padding: const EdgeInsets.only(right: 8),
      //                   child: FilterChip(
      //                     label: Text(name),
      //                     selected: isSelected,
      //                     onSelected: (_) => controller.onGenreChanged(isSelected ? null : id),
      //                   ),
      //                 );
      //               }),
      //             ],
      //           ),
      //         ),
      //         const SizedBox(height: 8),
      //         Expanded(
      //           child: Obx(() {
      //             final list = controller.mangaList;

      //             if (list.isEmpty && controller.searchQuery.isEmpty) {
      //               return const Center(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Icon(Icons.menu_book, size: 64, color: Colors.grey),
      //                     SizedBox(height: 12),
      //                     Text('No manga available', style: TextStyle(fontSize: 16)),
      //                   ],
      //                 ),
      //               );
      //             }

      //             return ListView.builder(
      //               controller: controller.scrollController,
      //               padding: const EdgeInsets.all(12),
      //               itemCount: list.length + 1,
      //               itemBuilder: (context, index) {
      //                 if (index == list.length) {
      //                   if (controller.isLoadingMore) {
      //                     return const Padding(
      //                       padding: EdgeInsets.all(16),
      //                       child: Center(child: CircularProgressIndicator()),
      //                     );
      //                   }

      //                   if (!controller.hasMore) {
      //                     return const Padding(
      //                       padding: EdgeInsets.all(16),
      //                       child: Center(
      //                         child: Text(
      //                           "You've reached the end",
      //                           style: TextStyle(color: Colors.grey),
      //                         ),
      //                       ),
      //                     );
      //                   }

      //                   return const SizedBox.shrink();
      //                 }

      //                 final manga = list[index];
      //                 // final id = manga['mal_id'];
      //                 final title = manga['title'] ?? 'No Title';
      //                 final image = manga['images']?['jpg']?['image_url'] ?? '';
      //                 // final isFav = controller.favouriteIds.contains(id);

      //                 return Card(
      //                   margin: const EdgeInsets.only(bottom: 12),
      //                   elevation: 2,
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(12),
      //                   ),
      //                   child: ListTile(
      //                     contentPadding: const EdgeInsets.all(10),
      //                     leading: ClipRRect(
      //                       borderRadius: BorderRadius.circular(10),
      //                       child: image.isNotEmpty
      //                           ? Image.network(
      //                               image,
      //                               width: 60,
      //                               height: 80,
      //                               fit: BoxFit.cover,
      //                               errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      //                               loadingBuilder: (context, child, progress) {
      //                                 if (progress == null) return child;
      //                                 return const SizedBox(
      //                                   width: 60,
      //                                   height: 80,
      //                                   child: Center(
      //                                     child: CircularProgressIndicator(strokeWidth: 2),
      //                                   ),
      //                                 );
      //                               },
      //                             )
      //                           : const Icon(Icons.image, size: 40),
      //                     ),
      //                     title: Text(
      //                       title,
      //                       maxLines: 2,
      //                       overflow: TextOverflow.ellipsis,
      //                       style: const TextStyle(fontWeight: FontWeight.w500),
      //                     ),
      //                     trailing: Obx(() {
      //                       final isFav = controller.favouriteIds.contains(manga['mal_id']);
      //                       return IconButton(
      //                         icon: Icon(
      //                           isFav ? Icons.bookmark : Icons.bookmark_border,
      //                           color: isFav ? Colors.indigo : null,
      //                         ),
      //                         onPressed: () {
      //                           controller.toggleFavourite(manga['mal_id']);
      //                         },
      //                       );
      //                     }),
      //                     onTap: () {
      //                       Get.to(() => const ImageViewerScreen(imageUrl: 'https://picsum.photos/id/25/600/3000'));
      //                     },
      //                   ),
      //                 );
      //               },
      //             );
      //           }),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

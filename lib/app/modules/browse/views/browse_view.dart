import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_track_app/app/services/components/shared/shared.dart';
import 'package:manga_track_app/app/services/utils/common.dart';
import 'package:manga_track_app/app/services/utils/global_style.dart';

import '../controllers/browse_controller.dart';

class BrowseView extends GetView<BrowseController> {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('MangaTrack', titleTextSize: 1.6),
      body: Row(
        children: [
          Container(
            width: gFontSize * 10,
            color: AppColors.background2,
            child: GetBuilder<BrowseController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.genres.length,
                  itemBuilder: (context, index) {
                    final isActive = controller.activeGenreIndex == index;
                    return GestureDetector(
                      onTap: () {
                        controller.scrollToGenre(index);
                      },
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 4,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.primary2 : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                              child: Text(
                                controller.genres[index],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: gFontSize * 1.2,
                                  fontWeight: FontWeight.w500,
                                  color: isActive ? AppColors.primary2 : AppColors.inverted,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: GetBuilder<BrowseController>(
              builder: (controller) {
                return ListView(
                  controller: controller.scrollController,
                  children: controller.genres.map((genre) {
                    final mangas = controller.grouped[genre]!;

                    return Container(
                      key: controller.sectionKeys[genre],
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            genre,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: gFontSize * 1.6,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...mangas.map((manga) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  Image.network(
                                    manga['images']['jpg']['image_url'],
                                    width: 50,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      manga['title'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: gFontSize * 0.9,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

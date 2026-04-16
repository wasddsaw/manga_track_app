import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_track_app/app/modules/discover/controllers/discover_controller.dart';
import 'package:manga_track_app/app/services/components/shared/shared.dart';
import 'package:manga_track_app/app/services/utils/common.dart';
import 'package:manga_track_app/app/services/utils/global_style.dart';

class FavouriteView extends GetView<DiscoverController> {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverController = Get.put(DiscoverController(mangaRepository: Get.find()));
    return Scaffold(
      appBar: const CustomAppBar('MangaTrack', titleTextSize: 1.6),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text(
                'PERSONAL LIBRARY',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: gFontSize,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Favourites',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: gFontSize * 2.1,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${discoverController.favouriteManga.length}  Series Tracked  •  Last read 2h ago',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: gFontSize,
                  fontWeight: FontWeight.w500,
                  color: AppColors.inverted,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: discoverController.favouriteManga.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bookmark_border, size: gFontSize * 6, color: Colors.grey),
                            const SizedBox(height: 12),
                            Text(
                              'No favourites yet — start exploring!',
                              style: TextStyle(fontSize: gFontSize * 1.2, color: AppColors.inverted),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: discoverController.favouriteManga.length,
                        itemBuilder: (context, index) {
                          final manga = discoverController.favouriteManga[index];

                          final id = manga['mal_id'];
                          final title = manga['title'] ?? 'No Title';
                          final image = manga['images']?['jpg']?['image_url'] ?? '';

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(8),
                              leading: image.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        image,
                                        width: 60,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(Icons.image, size: 40),
                              title: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  discoverController.toggleFavourite(id);
                                },
                              ),
                              onTap: () => {},
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

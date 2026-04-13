import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_track_app/app/modules/discover/controllers/discover_controller.dart';

class FavouriteView extends GetView<DiscoverController> {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverController = Get.put(DiscoverController(mangaRepository: Get.find()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        centerTitle: true,
      ),
      body: Obx(() {
        final favList = discoverController.favouriteManga;

        if (favList.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text(
                  'No favourites yet — start exploring!',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: favList.length,
          itemBuilder: (context, index) {
            final manga = favList[index];

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
        );
      }),
    );
  }
}

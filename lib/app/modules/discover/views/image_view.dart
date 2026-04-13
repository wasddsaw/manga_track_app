import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageViewerController extends GetxController {
  final String imageUrl;

  ImageViewerController(this.imageUrl);

  final transformationController = TransformationController();

  var isZoomed = false.obs;

  TapDownDetails? doubleTapDetails;

  void onInteractionUpdate(ScaleUpdateDetails details) {
    final scale = transformationController.value.getMaxScaleOnAxis();
    isZoomed.value = scale > 1.0;
  }

  void onDoubleTapDown(TapDownDetails details) {
    doubleTapDetails = details;
  }

  void onDoubleTap() {
    if (doubleTapDetails == null) return;

    final position = doubleTapDetails!.localPosition;

    final currentScale = transformationController.value.getMaxScaleOnAxis();

    if (currentScale > 1.0) {
      // 🔄 Reset
      transformationController.value = Matrix4.identity();
      isZoomed.value = false;
    } else {
      // 🔍 Zoom into tapped position
      const zoom = 2.5;

      final x = -position.dx * (zoom - 1);
      final y = -position.dy * (zoom - 1);

      transformationController.value = Matrix4.identity()
        ..translate(x, y)
        ..scale(zoom);

      isZoomed.value = true;
    }
  }

  void resetZoom() {
    transformationController.value = Matrix4.identity();
    isZoomed.value = false;
  }
}

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;

  const ImageViewerScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GetX<ImageViewerController>(
      init: ImageViewerController(imageUrl),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics:
                    controller.isZoomed.value ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                child: GestureDetector(
                  onDoubleTapDown: controller.onDoubleTapDown,
                  onDoubleTap: controller.onDoubleTap,
                  child: InteractiveViewer(
                    transformationController: controller.transformationController,
                    panEnabled: true,
                    scaleEnabled: true,
                    minScale: 1.0,
                    maxScale: 4.0,
                    onInteractionUpdate: controller.onInteractionUpdate,
                    child: Image.network(
                      controller.imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              if (controller.isZoomed.value)
                Positioned(
                  bottom: 30,
                  right: 20,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: controller.resetZoom,
                    child: const Icon(Icons.refresh),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

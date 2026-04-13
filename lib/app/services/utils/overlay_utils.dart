part of 'common.dart';

class OverlayUtils {
  static void showSnackbar({String message = ''}) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.BOTTOM,
        mainButton: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: GestureDetector(
            child: Icon(Icons.close, color: Colors.white, size: gFontSize * 1.6),
            onTap: () {
              if (Get.isSnackbarOpen) {
                Get.closeCurrentSnackbar();
              }
            },
          ),
        ),
      ),
    );
  }

  static void showLoading({String? message}) {
    Get.dialog(
      const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        content: Wrap(
          children: [
            LoadingIndicator(),
          ],
        ),
      ),
    );
  }

  static void closeLoading() {
    Get.back();
  }

  static void showWarningDialog(String title, String description, VoidCallback onPressed,
      {String btnBack = 'Go Back'}) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Column(
          children: [
            Image.asset(CustomAssetPath.warningIcon, width: Get.width * 0.15),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: gFontSize * 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
                fontSize: gFontSize,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(label: btnBack, onPressed: onPressed),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

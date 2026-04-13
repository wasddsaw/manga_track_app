import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:manga_track_app/app/services/utils/common.dart';
import 'package:manga_track_app/main_binding.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainBinding().dependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      GetMaterialApp(
        defaultTransition: Transition.rightToLeftWithFade,
         title: "MangaTrack",
        theme: appTheme(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  });
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:manga_track_app/app/modules/browse/controllers/browse_controller.dart';
import 'package:manga_track_app/app/services/utils/common.dart';

import '../../../services/utils/global_style.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.screenList[controller.activeBottomNavBarIndex.value],
        bottomNavigationBar: Theme(
          data: ThemeData(splashColor: Colors.transparent),
          child: SizedBox(
            height: Get.width * 0.16,
            child: BottomNavigationBar(
              backgroundColor: AppColors.background3.withValues(alpha: 0.8),
              selectedFontSize: gFontSize * 0.8,
              selectedItemColor: AppColors.primary2,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, height: Get.width * 0.006),
              iconSize: Get.width * 0.06,
              unselectedFontSize: gFontSize * 0.8,
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
              unselectedItemColor: AppColors.inverted,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.activeBottomNavBarIndex.value,
              items: controller.bottomNavBarItem,
              onTap: (index) {
                controller.activeBottomNavBarIndex.value = index;
                if (index == 2) {
                  Get.log('test $index');
                  Get.put(BrowseController());
                  Get.find<BrowseController>().onReload();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

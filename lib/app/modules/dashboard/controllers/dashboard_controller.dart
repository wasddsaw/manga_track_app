import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_track_app/app/modules/browse/views/browse_view.dart';
import 'package:manga_track_app/app/modules/discover/views/discover_view.dart';
import 'package:manga_track_app/app/modules/favourite/views/favourite_view.dart';

class DashboardController extends GetxController {
  RxInt activeBottomNavBarIndex = RxInt(0);

  List<Widget> screenList = [
    const DiscoverView(),
    const FavouriteView(),
    const BrowseView(),
  ];

  List<BottomNavigationBarItem> bottomNavBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: 'Discover',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline),
      activeIcon: Icon(Icons.favorite),
      label: 'Favourites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu_book_outlined),
      activeIcon: Icon(Icons.menu_book),
      label: 'Browse',
    ),
  ];
}

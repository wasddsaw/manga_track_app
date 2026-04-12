import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favourite_controller.dart';

class FavouriteView extends GetView<FavouriteController> {
  const FavouriteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavouriteView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FavouriteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

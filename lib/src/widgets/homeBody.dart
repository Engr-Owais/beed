import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/beer_controller.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.loadDataFromApi,
      child: Obx(
        () {
          if (controller.isLoading.value && controller.beers.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              controller: controller.scrollController,
              itemCount:
                  controller.beers.length + 1, // +1 for the loading indicator
              itemBuilder: (context, index) {
                if (index < controller.beers.length) {
                  final beer = controller.beers[index];
                  return ListTile(
                    title: Text(beer.name),
                    subtitle: Text(beer.tagline),
                  );
                } else {
                  if (!controller.isLoading.value) {
                    controller.loadDataFromApi();
                  }
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

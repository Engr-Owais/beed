import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/beer_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value && controller.beers.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.beers.length + 1, // +1 for the loading indicator
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

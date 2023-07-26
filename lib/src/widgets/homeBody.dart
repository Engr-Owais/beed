import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/api_controller.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.controller,
  });

  final ApiController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.loading.value && controller.result.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.isInternetConnected.isTrue
                ? controller.result.length + 1
                : controller.result.length,  // +1 for the loading indicator
            itemBuilder: (context, index) {
              if (index < controller.result.length) {
                final beer = controller.result[index];
                return ListTile(
                  title: Text(beer.name),
                  subtitle: Text(beer.url),
                );
              } else {
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
    );
  }
}

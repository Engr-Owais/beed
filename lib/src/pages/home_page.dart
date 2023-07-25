import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/beer_controller.dart';
import '../widgets/drawer.dart';
import '../widgets/homeBody.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: CustomDrawer(),
      body: HomeBody(controller: controller),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/api_controller.dart';
import '../widgets/drawer.dart';
import '../widgets/homeBody.dart';

class HomePage extends StatelessWidget {
  final ApiController controller = Get.put(ApiController());
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LogoutPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('LOGOUT'),
        ),
        body: Container(
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  controller.signOutUser();
                  controller.deleteLoginSession();
                },
                child: Text("LOGOUT")),
          ),
        ),
      ),
    );
  }
}

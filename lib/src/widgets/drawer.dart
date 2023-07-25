import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Menu Item 1'),
            onTap: () {
              
              Get.to(Menu1());
            },
          ),
          ListTile(
            title: Text('Menu Item 2'),
            onTap: () {
              Get.to(Menu2());
            },
          ),
        ],
      ),
    );
  }
}

class Menu1 extends StatelessWidget {
  const Menu1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("MENU 1"),
      ),
      body: Center(child: Text("MENU 1")),
    );
  }
}

class Menu2 extends StatelessWidget {
  const Menu2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("MENU 2"),
      ),
      body: Center(child: Text("MENU 2")),
    );
  }
}

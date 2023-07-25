import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Menu Item 1'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Menu Item 2'),
            onTap: () {},
          ),
          // Add more menu items as needed.
        ],
      ),
    );
  }
}

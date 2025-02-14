import 'package:flutter/material.dart';
import 'config_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.timer),
            title: Text('Start Timer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfigScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfigScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.coffee),
            title: Text('Buy me a Coffee.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfigScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

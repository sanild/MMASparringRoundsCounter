import 'package:flutter/material.dart';
import 'package:sparring_rounds_app/screens/about_screen.dart';
import 'config_screen.dart';
import 'settings_screen.dart';
import 'package:flutter/cupertino.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30), // RGB 51,51,51
      child: Column(
        children: <Widget>[
          // Header with the same background color.
          Container(
            height: 100, // Adjust as needed.
            color: const Color.fromARGB(255, 30,30,30),
            child: const Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Expanded list of menu items.
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.timer, color: Colors.white, size: 30.0),
                  title: const Text(
                    'Timer',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfigScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.coffee, color: Colors.white, size: 30),
                  title: const Text(
                    'Buy me a Coffee.',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfigScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white, size: 30),
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.info_circle_fill, color: Colors.white, size: 30),
                  title: const Text(
                    'About',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          // Footer with version and "Made in Montreal with ♥" text.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'v 1.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(text: "Made in Montreal with "),
                      WidgetSpan(
                        child: Icon(
                          Icons.favorite,
                          color: const Color(0xFFFF1744), // Heart icon color.
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

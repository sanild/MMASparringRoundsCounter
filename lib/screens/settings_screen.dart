import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Local state for the dark mode switch. Always starts on.
  bool _darkModeSwitch = true;

  @override
  void initState() {
    super.initState();
    // Optionally initialize from the provider.
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    _darkModeSwitch = settings.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/images/pain au chocolat.png"),
                  height: 150,
                ),
                const SizedBox(height: 8),
                const Divider(
                  color: Colors.white,
                  thickness: 0.3,
                  indent: 1,
                  endIndent: 1,
                ),
              ],
            ),
          ),
          // Expanded scrollable settings content.
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
                vertical: 2.0,
              ),
              child: Column(
                children: [
                  // Dark Mode Setting
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: const Icon(
                      Icons.dark_mode,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Dark Mode",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    trailing: Switch(
                      value: _darkModeSwitch,
                      onChanged: (bool value) async {
                        if (!value) {
                          // User tries to turn dark mode off.
                          setState(() {
                            _darkModeSwitch = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Sorry, light mode isn't there yet.",
                              ),
                            ),
                          );
                          // Wait briefly so the switch shows off.
                          await Future.delayed(
                            const Duration(milliseconds: 300),
                          );
                          // Revert back to on.
                          setState(() {
                            _darkModeSwitch = true;
                          });
                          settings.toggleDarkMode(true);
                        } else {
                          // If toggled on, ensure it stays on.
                          setState(() {
                            _darkModeSwitch = true;
                          });
                          settings.toggleDarkMode(true);
                        }
                      },
                    ),
                  ),
                  // Full Screen Setting
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Full Screen",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    trailing: Switch(
                      value: settings.fullScreen,
                      onChanged: (value) => settings.toggleFullScreen(value),
                    ),
                  ),
                  // Vibration Setting
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: const Icon(
                      Icons.vibration,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Vibration",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    trailing: Switch(
                      value: settings.enableVibration,
                      onChanged: (value) => settings.toggleVibration(value),
                    ),
                  ),
                  // Sounds Setting
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: const Icon(
                      Icons.volume_up,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Sounds",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    trailing: Switch(
                      value: settings.enableSounds,
                      onChanged: (value) => settings.toggleSounds(value),
                    ),
                  ),
                  // Notifications Setting
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Notifications",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    trailing: Switch(
                      value: settings.enableNotifications,
                      onChanged: (value) => settings.toggleNotifications(value),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Footer that always remains visible at the bottom.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'v 1.00',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    children: [
                      TextSpan(text: "Made in Montreal with "),
                      WidgetSpan(
                        child: Icon(
                          Icons.favorite,
                          color: Color(0xFFFF1744),
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

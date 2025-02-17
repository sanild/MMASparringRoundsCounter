import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      ),
      body: Column(
        children: [
          // Expanded scrollable content.
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header for General Settings
                  const Text(
                    "General",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Dark Mode Setting
                  ListTile(
                    leading: const Icon(Icons.dark_mode, color: Colors.white, size: 30),
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
                              content: Text("Sorry, dark mode is permanently on."),
                            ),
                          );
                          // Wait briefly so the switch shows off.
                          await Future.delayed(const Duration(milliseconds: 300));
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
                    leading: const Icon(Icons.fullscreen, color: Colors.white, size: 30),
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
                    leading: const Icon(Icons.vibration, color: Colors.white, size: 30),
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
                    leading: const Icon(Icons.volume_up, color: Colors.white, size: 30),
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
                    leading: const Icon(Icons.notifications, color: Colors.white, size: 30),
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
                          color: const Color(0xFFFF1744),
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

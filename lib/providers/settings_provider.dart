import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsProvider extends ChangeNotifier {
  bool _fullScreen = false;
  bool _enableVibration = true;
  bool _enableSounds = true;
  bool _enableNotifications = true;
  bool _enableDarkMode = true;

  bool get fullScreen => _fullScreen;
  bool get enableVibration => _enableVibration;
  bool get enableSounds => _enableSounds;
  bool get enableNotifications => _enableNotifications;
  bool get darkMode => _enableDarkMode;

  void toggleFullScreen(bool value) {
    _fullScreen = value;
    if (_fullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    notifyListeners();
  }

  void toggleVibration(bool value) {
    _enableVibration = value;
    notifyListeners();
  }

  void toggleSounds(bool value) {
    _enableSounds = value;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _enableNotifications = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _enableDarkMode = true;
    notifyListeners();
  }
}

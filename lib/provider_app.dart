import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  ThemeData theme = ThemeData(brightness: Brightness.light);
  bool isDarkTheme = false;
  ThemeData lightTheme = ThemeData(brightness: Brightness.light);
  ThemeData darkTheme = ThemeData(brightness: Brightness.dark);

  AppProvider() {
    _alreadyRegistered();
    _checkTheme();
  }

  bool isStorageGranted = true;
  bool isRegistered = false;

  // check file permission are allowed
  checkPermission() async {
    if (await Permission.storage.request().isGranted) {
      await _registerDevice();
      isRegistered = true;
      notifyListeners();
    } else {
      var status = await Permission.storage.status;
      if (status.isPermanentlyDenied) {
        isStorageGranted = false;
        notifyListeners();
      }
    }
  }

  _registerDevice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = new Uuid();
    await prefs.setString('device-id', uuid.v1());
  }

  _alreadyRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var deviceid = prefs.getString('device-id');
    if (deviceid != null) {
      isRegistered = true;
      notifyListeners();
    }
  }

  //ThemeData.
  bool get isDarkMode {
    return isDarkTheme;
  }

  ThemeData get currentTheme {
    return theme;
  }

  setTheme(mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mode == 'light') {
      isDarkTheme = false;
      theme = ThemeData(brightness: Brightness.light);
      await prefs.setString('theme', 'light');
    } else {
      isDarkTheme = true;
      theme = ThemeData(brightness: Brightness.dark);
      await prefs.setString('theme', 'dark');
    }
    notifyListeners();
  }

  _checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedpref = prefs.getString('theme');
    if (theme != null) {
      setTheme(savedpref);
      notifyListeners();
    }
  }
}

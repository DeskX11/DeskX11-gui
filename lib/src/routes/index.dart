import 'package:flutter/material.dart';
import '../screens/home/index.dart';
import '../screens/settings/index.dart';
import '../screens/unknown/index.dart';

Route routes(RouteSettings settings) {
  // Handle '/'
  if (settings.name == '/') {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }

  // Handle '/settings'
  if (settings.name == '/settings') {
    return MaterialPageRoute(builder: (context) => SettingsScreen());
  }

  return MaterialPageRoute(builder: (context) => UnknownScreen());
}

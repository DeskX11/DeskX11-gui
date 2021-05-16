import 'package:flutter/material.dart';
import '../../features/settings/settings-page.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: SettingPage());
  }
}

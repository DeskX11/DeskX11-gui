import 'package:flutter/material.dart';
import '../../models/settings.dart';
import '../../utils/db.dart';
import './form-settings.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Settings _settings = Settings();

  void _update() async {
    await DB.update(Settings.table, _settings);
    refresh();
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(Settings.table);
    setState(() {
      _settings = _results.map((item) => Settings.fromMap(item)).toList()[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                width: 400,
                child: FormSetting(
                  settings: _settings,
                  save: () => _update(),
                ))));
  }
}

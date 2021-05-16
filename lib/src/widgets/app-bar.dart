import 'package:flutter/material.dart';
import '../utils/app-state-notifier.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget {
  final Widget child;
  AppBarWidget({Key key, @required this.child}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<AppStateNotifier>(context, listen: false).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text('DeskX'),
        actions: <Widget>[
          IconButton(
            icon: isDarkMode
                ? Icon(Icons.nightlight_round)
                : Icon(Icons.wb_sunny),
            tooltip: 'Change Theme',
            onPressed: () {
              Provider.of<AppStateNotifier>(context, listen: false)
                  .updateTheme(!isDarkMode);
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Setting',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/settings',
              );
            },
          ),
        ],
      ),
      body: widget.child,
    );
  }
}

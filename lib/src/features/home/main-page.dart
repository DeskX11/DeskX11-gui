import 'package:flutter/material.dart';
import '../../utils/app-state-notifier.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  final String text;
  MainPage({Key key, @required this.text}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Row(children: [
            TextButton(
              child: Text('View Details'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details/1',
                );
              },
            ),
            Switch(
              value: Provider.of<AppStateNotifier>(context).isDarkMode,
              onChanged: (value) {
                Provider.of<AppStateNotifier>(context, listen: false)
                    .updateTheme(value);
              },
            ),
            Text(widget.text)
          ])
        ]),
      ),
    );
  }
}

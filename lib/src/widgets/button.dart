import 'package:flutter/material.dart';
import '../utils/app-state-notifier.dart';
import 'package:provider/provider.dart';

class ButtonWidget extends StatefulWidget {
  final double size;
  final String text;
  final VoidCallback onPressed;
  ButtonWidget({
    Key key,
    @required this.size,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<AppStateNotifier>(context, listen: false).isDarkMode;
    return ElevatedButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: new TextStyle(
              fontSize: widget.size,
              color: isDarkMode ? Colors.black : Colors.white),
        ));
  }
}

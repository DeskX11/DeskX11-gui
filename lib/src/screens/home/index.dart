import 'package:flutter/material.dart';
import '../../features/home/main-page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
      ),
      body: MainPage(text: 'props'),
    );
  }
}

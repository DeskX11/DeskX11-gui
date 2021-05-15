import 'package:flutter/material.dart';
import '../../features/home/main-page.dart';
import '../../widgets/app-bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarWidget(children: MainPage()),
    );
  }
}

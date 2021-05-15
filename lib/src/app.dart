import 'config/theme-data.dart';
import 'config/string-constants.dart';
import 'utils/app-state-notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './routes/index.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
        title: APP_NAME,
        theme: ThemeConfig.lightTheme,
        darkTheme: ThemeConfig.darkTheme,
        themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        onGenerateRoute: routes,
      );
    });
  }
}

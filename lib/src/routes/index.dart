import 'package:flutter/material.dart';
import '../screens/home/index.dart';
import '../screens/detail/index.dart';
import '../screens/unknown/index.dart';

Route routes(RouteSettings settings) {
  // Handle '/'
  if (settings.name == '/') {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }

  // Handle '/details/:id'
  var uri = Uri.parse(settings.name);
  if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'details') {
    var id = uri.pathSegments[1];
    return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
  }

  return MaterialPageRoute(builder: (context) => UnknownScreen());
}

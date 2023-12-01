import 'package:flutter/material.dart';
import 'package:test/model/arguments/detail_screen_argument.dart';
import 'package:test/screens/detail_screen.dart';
import 'package:test/screens/search_screen.dart';

class AppRoutes {
  static const String search = '/images/search';
  static const String details = '/images/details';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case AppRoutes.details:
        final args = settings.arguments as DetailScreenArgument;
        return MaterialPageRoute(
            builder: (_) => DetailScreen(
                  args: args,
                ));
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }

  static List<Route<dynamic>> initialRoutes(String initialRoute) {
    return [
      MaterialPageRoute(builder: (_) => const SearchScreen()),
    ];
  }
}

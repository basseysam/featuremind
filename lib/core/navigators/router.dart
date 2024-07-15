
import 'package:featureminds/core/navigators/route_names.dart';
import 'package:featureminds/features/dashboard/pages/search_screen.dart';
import 'package:featureminds/features/dashboard/pages/dashboard_screen.dart';
import 'package:featureminds/features/onboarding/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../../features/onboarding/pages/spash_screen.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const SplashScreen());

    case Routes.welcome:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const WelcomeScreen());

    case Routes.search:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const SearchScreen());

    case Routes.dashboard:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const DashBoardScreen());


    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow!,
  );
}

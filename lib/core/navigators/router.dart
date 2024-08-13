
import 'package:featureminds/core/navigators/route_names.dart';
import 'package:featureminds/features/dashboard/pages/dashboard_screen.dart';
import 'package:featureminds/features/dashboard/pages/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../features/dashboard/models/post_model.dart';
import '../../features/onboarding/pages/spash_screen.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const SplashScreen());


    case Routes.dashboard:
      return _getPageRoute(
          routeName: settings.name, viewToShow:  DashBoardScreen(posts: settings.arguments as List<Post>,));

    case Routes.profile:
      return _getPageRoute(
          routeName: settings.name, viewToShow:  ProfileScreen(post: settings.arguments as List<Post>,));


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

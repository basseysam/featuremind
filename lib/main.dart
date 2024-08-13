import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/navigators/route_names.dart';
import 'core/navigators/router.dart';
import 'core/utils/constants.dart';
import 'firebase_options.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  overrideNavColors();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: "Featuremind",
        theme: kThemeData,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

void overrideNavColors() {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      /// Set StatusBar Customization.
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,

      /// Set NavigationBar Customization.
      //systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  } else if (Platform.isIOS) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      /// Set StatusBar Customization.
      statusBarBrightness: Brightness.dark,
    ));
  }
}

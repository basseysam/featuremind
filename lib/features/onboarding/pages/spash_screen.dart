import 'package:featureminds/core/utils/app_colors.dart';
import 'package:featureminds/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/navigators/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _move(){
   Navigator.pushNamed(context, Routes.welcome);
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 4500), _move);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Lottie.asset(
            AppString.splashLottie,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width *.80,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

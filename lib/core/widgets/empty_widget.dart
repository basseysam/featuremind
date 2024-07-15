import 'package:featureminds/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import 'custom_text.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/json/empty.json',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          CustomText(
            title,
            fontSize: 16,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
          )
        ],
      ),

    );
  }
}

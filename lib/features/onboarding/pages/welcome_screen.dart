import 'package:featureminds/core/navigators/navigators.dart';
import 'package:featureminds/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SlideInDown(
                preferences: const AnimationPreferences(
                    duration: Duration(milliseconds: 1000)),
                child: InOutAnimation(
                  inDefinition: FadeInAnimation(),
                  outDefinition: BounceOutDownAnimation(),
                  child: Image.asset(
                    AppString.homeImage,
                    height: 260.26,
                    width: 350,
                  ),
                ),
              ),
              const Gap(10),
              SlideInLeft(
                preferences: const AnimationPreferences(
                    duration: Duration(milliseconds: 1000)),
                child: InOutAnimation(
                  inDefinition: FadeInAnimation(),
                  outDefinition: BounceOutDownAnimation(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "NO",
                                style: GoogleFonts.redHatDisplay(
                                    color: Colors.black,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w700)),
                            TextSpan(
                                text: " stress",
                                style: GoogleFonts.redHatDisplay(
                                    color: AppColors.secondaryColor,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: ".",
                                style: GoogleFonts.redHatDisplay(
                                    color: AppColors.black,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              SlideInLeft(
                preferences: const AnimationPreferences(
                    duration: Duration(milliseconds: 1000)),
                child: InOutAnimation(
                  inDefinition: FadeInAnimation(),
                  outDefinition: BounceOutDownAnimation(),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Shop",
                            style: GoogleFonts.redHatDisplay(
                                color: AppColors.primaryColor,
                                fontSize: 48,
                                fontWeight: FontWeight.w900)),
                        TextSpan(
                            text: " more.",
                            style: GoogleFonts.redHatDisplay(
                                color: AppColors.black,
                                fontSize: 48,
                                fontWeight: FontWeight.w900)),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const Gap(10),
              ZoomIn(
                  preferences: const AnimationPreferences(
                      duration: Duration(milliseconds: 1300)),
                  child: InOutAnimation(
                      inDefinition: FadeInAnimation(),
                      outDefinition: BounceOutDownAnimation(),
                      child: const CustomText(
                        'Shop with ease from the comfort of your home and supercharge productivity with Featuremind',
                        textAlign: TextAlign.center,
                        fontSize: 16,
                      ))),
              const Spacer(),
              FadeInLeft(
                preferences: const AnimationPreferences(
                    duration: Duration(milliseconds: 1000)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PrimaryButton(
                    title: "Get Started",
                    suffixIcon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPress: () {
                      Navigator.pushNamedAndRemoveUntil(context, Routes.search, (route) => false);
                    },
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

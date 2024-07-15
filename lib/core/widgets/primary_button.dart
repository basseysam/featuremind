import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.disabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.textColor,
    this.icon,
    this.backgroundColor,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);
  final String title;
  final VoidCallback onPress;
  final double? width;
  final double? height;
  final String? icon;
  final bool disabled;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPress,
      child: Container(
        height: height ?? 55,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: disabled ? const Color(0xffF0F3F6) : backgroundColor ?? AppColors.primaryColor,
          borderRadius: borderRadius ?? BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(
                  -2, 4), // changes position of shadow
            ),
          ],
        ),
        child: isLoading == true
            ?  CupertinoActivityIndicator(
          color: AppColors.white,
        )
            : Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              prefixIcon ?? const SizedBox(),
              const Gap(5),
              Center(
                child: CustomText(
                  title,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: !disabled
                      ? textColor ?? AppColors.white
                      : Colors.grey,
                ),
              ),
              const Gap(5),
              suffixIcon ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
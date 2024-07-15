import 'package:featureminds/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomText extends StatelessWidget {
  const CustomText(
      this.text, {
        this.style,
        this.fontSize = 14,
        this.color,
        this.textAlign = TextAlign.left,
        this.overflow = TextOverflow.visible,
        this.fontWeight = FontWeight.w400,
        this.fontStyle = FontStyle.normal,
        Key? key,
      }) : super(key: key);
  final String? text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    assert(text != null, 'test can not be null');
    return Text(
      text ?? '',
      softWrap: true,
      style:  GoogleFonts.redHatDisplay(
        fontSize: fontSize,
        color: color ?? AppColors.bodyTextColor,
        fontStyle: fontStyle,
        fontWeight: fontWeight
      ).merge(style),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';


class TextInputNoIcon extends StatefulWidget {

  const TextInputNoIcon(
      {Key? key,
        this.text,
        this.icon,
        this.errorText,
        this.prefixWidget,
        this.onSaved,
        this.onChanged,
        this.onEditingComplete,
        this.onTapInfo,
        this.height = 50,
        this.inputType = TextInputType.text,
        this.inputAction,
        this.controller,
        this.inputFormatters,
        this.autoFillHints,
        this.validator,
        this.maxLines = 1,
        this.autocorrect = false,
        this.enableSuggestions = false,
        this.contentPadding,
        this.onTapField,
        this.hintText,
        this.obscure,
        this.border,
        this.textCapitalization = TextCapitalization.words,
        this.textAlign = TextAlign.left,
        this.autoValidateMode = AutovalidateMode.disabled,
        this.read = false,
        this.allowPaste = true,
        this.requiredField = false,
        this.readNoShade = false,
        this.hasInfo = false,
        this.showCursor = true,
        this.autoFocus = false,
        this.isError = false,
        this.showTitle = true,
        this.focusNode,
        this.fillColor,
        this.password = false,
        this.errorTextStyle,
        this.textStyle})
      : super(key: key);

  final String? text;
  final Widget? icon, prefixWidget;
  final bool? obscure;
  final bool read,
      readNoShade,
      isError,
      autocorrect,
      enableSuggestions,
      showCursor,
      requiredField,
      hasInfo,
      allowPaste,
      autoFocus,
      showTitle;
  final int maxLines;
  final Color? fillColor;
  final String? hintText, errorText;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback? onTapInfo, onTapField;
  final Function(String?)? onSaved, onChanged;
  final TextAlign textAlign;
  final TextCapitalization? textCapitalization;
  final Function()? onEditingComplete;
  final TextInputType inputType;
  final TextInputAction? inputAction;
  final TextStyle? textStyle;
  final AutovalidateMode autoValidateMode;
  final TextStyle? errorTextStyle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autoFillHints;
  final String? Function(String?)? validator;
  final bool password;
  final double? height;

  @override
  State<TextInputNoIcon> createState() => _TextInputNoIconState();
}

class _TextInputNoIconState extends State<TextInputNoIcon>{

  late bool isPassword;
  double fieldHeight = 64;

  @override
  void initState() {
    super.initState();
    isPassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.text != null) const SizedBox(height: 3),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                keyboardType: widget.inputType,
                textInputAction: widget.inputAction,
                enableSuggestions: widget.enableSuggestions,
                enableInteractiveSelection: widget.allowPaste,
                readOnly: widget.read,
                style: widget.textStyle ??
                    GoogleFonts.redHatDisplay(
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyTextColor,
                    ),
                cursorColor: AppColors.primaryColor,
                //obscureText: widget.obscure == null ? false : widget.obscure!,
                obscureText: isPassword,
                onSaved: widget.onSaved,
                validator: widget.validator,
                controller: widget.controller,
                textAlign: widget.textAlign,
                focusNode: widget.focusNode,
                autofocus: widget.autoFocus,
                autocorrect: widget.autocorrect,
                autofillHints: widget.autoFillHints,
                maxLines: widget.maxLines,
                onTap: widget.onTapField,
                showCursor: widget.read ? false : widget.showCursor,
                textCapitalization: widget.textCapitalization ?? TextCapitalization.words,
                autovalidateMode: widget.autoValidateMode,
                onChanged: widget.onChanged,
                onEditingComplete: widget.onEditingComplete,
                inputFormatters: widget.inputFormatters,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 13),
                  isDense: true,
                  filled: true,
                  prefixIcon: widget.prefixWidget,
                  errorStyle: GoogleFonts.redHatDisplay(color: Colors.red, fontSize: 10, fontWeight: FontWeight.w400, height: 0.1),
                  hintText: widget.hintText,
                  hintStyle:  GoogleFonts.redHatDisplay(color: Colors.black.withOpacity(0.4), fontSize: 14,  fontWeight: FontWeight.w500),
                  suffixIcon: widget.password ? GestureDetector(
                    onTap: () => setState(() {
                      isPassword = !isPassword;
                    }),
                    child: widget.password
                        ? Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      child: Icon(
                        isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xffD0D5DD),
                        size: 25,
                      ),
                    )
                        : Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                    ),
                  ) :  widget.icon,
                  errorText: widget.errorText,
                  fillColor: widget.read == true
                      ? widget.readNoShade
                      ? Colors.grey
                      : Colors.transparent
                      : Colors.transparent ?? AppColors.bodyTextColor,
                  border: widget.border ??  OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: AppColors.primaryColor)
                  ),
                  enabledBorder: widget.border ??
                      OutlineInputBorder(
                        borderSide:  BorderSide(width: 1, color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(7),
                      ),
                  focusedBorder: widget.border ??
                      OutlineInputBorder(
                        borderSide: BorderSide(color: widget.read == true ? AppColors.primaryColor : AppColors.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(7),
                      ),
                  errorBorder:  OutlineInputBorder(
                    // gapPadding: 30.0,
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    //gapPadding: 30.0,
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -1,
              left: 12,
              child: Visibility(
                visible: widget.showTitle,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: RichText(
                      text: TextSpan(
                        style: textTheme.subtitle1?.copyWith(color: Colors.black87),
                        children: [
                          TextSpan(text: widget.text, style: GoogleFonts.redHatDisplay(fontSize: 12, color: AppColors.black.withOpacity(0.6), fontWeight: FontWeight.w500)),
                          TextSpan(
                            text: widget.requiredField ? " *" : "",
                            style: GoogleFonts.redHatDisplay(fontSize: 14, color: Colors.red, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}


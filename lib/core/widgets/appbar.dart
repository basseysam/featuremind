
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.title, this.actions});
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.backgroundColor,
      leading: Navigator.canPop(context)
          ? Padding(
              padding: const EdgeInsets.only(left: 5, top: 20, right: 20,bottom: 7 ),
              child: Transform(
                transform: Matrix4.translationValues(15.0, 0.0, 0.0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset('assets/icons/back_arrow.svg', color: AppColors.primaryColor, fit: BoxFit.contain, height: 20, width: 20,),
                ),
              ),
            )
          : const SizedBox(),
      title: title != null
          ? CustomText(
              title!,
              fontSize: 16,
              color: AppColors.bodyTextColor,
              overflow: TextOverflow.ellipsis,
            )
          : Container(),

      centerTitle: true,
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}


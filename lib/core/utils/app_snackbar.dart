import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

SnackBar getSnackBar(String message, {bool isError = false}) {
  SnackBar snackBar = SnackBar(
    content: Text(message, ),
    backgroundColor: isError ? Colors.red : Colors.green,
    dismissDirection: DismissDirection.none,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(left: 20, right: 20.0),
  );
  return snackBar;
}

showToast(String message, BuildContext context) {
  return showTopSnackBar(
      Overlay.of(context),
      Material(
        color: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                color: Colors.red.withOpacity(0.3),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Success",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w700,
                                fontSize: 14)),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(message,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.close,
                  color: Colors.deepOrange,
                )
              ],
            )),
      ),
      padding: const EdgeInsets.all(15));
}

showErrorToast(String message, BuildContext context) {
  return showTopSnackBar(
      Overlay.of(context),
      Material(
        color: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              border: Border.all(
                color: Colors.deepOrange,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Error Occurred",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(message,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16, // Adjust as needed
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                Icon(Icons.close)
              ],
            )),
      ));

  // return showTopSnackBar(
  //   Overlay.of(NavigationService.navigationKey_.currentContext!),
  //   CustomSnackBar.info(
  //     backgroundColor: AppColors.red,
  //     message: message,
  //   ),
  // );
}

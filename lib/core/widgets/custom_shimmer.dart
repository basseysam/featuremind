import 'package:featureminds/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';


class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 200,
        padding: const EdgeInsets.only(left: 0.0, right: 0),
        child: Center(
          child: Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              period: const Duration(seconds: 2),
              baseColor: AppColors.primaryColor.withOpacity(0.1),
              highlightColor: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: AlignedGridView.count(
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 170,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            const Gap(5),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        );
                      },
                      itemCount: 4,
                    ),
                  ),
                ],
              )),
        ));
  }
}

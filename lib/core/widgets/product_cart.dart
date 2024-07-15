import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

import '../../features/dashboard/models/product_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import 'custom_text.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productModel
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
          height: 170,
          imageUrl: productModel.images[0],
          errorWidget: (error, child, _) {
            return CachedNetworkImage(
              imageUrl:
              AppString.errorImage,
              fit: BoxFit.cover,
            );
          },
        ),
        const Gap(5),
        CustomText(
          productModel.title,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          "\$${productModel.price.toString()}",
          color: AppColors.bodyTextColor.withOpacity(0.7),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
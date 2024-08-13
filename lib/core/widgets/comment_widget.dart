import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../features/dashboard/models/post_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/constants.dart';
import 'custom_text.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(imageUrl: comment.sender.imageUrl, height: 45, width: 45, fit: BoxFit.cover,)),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(comment.sender.name, fontWeight: FontWeight.w700, fontSize: 16,),
              CustomText(comment.commentText, fontWeight: FontWeight.w500,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(formatTimestamp(comment.createdAt), color: Colors.grey, fontWeight: FontWeight.w500,),
                      const Gap(10),
                      const CustomText("Reply", color: AppColors.primaryColor, fontWeight: FontWeight.w700,),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.favorite_border),
                      const Gap(5),
                      CustomText(comment.likes.toString(), color: AppColors.black, fontWeight: FontWeight.w700,),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),

      ],
    );
  }
}
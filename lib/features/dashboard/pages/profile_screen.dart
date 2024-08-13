import 'package:cached_network_image/cached_network_image.dart';
import 'package:featureminds/features/dashboard/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.post});
  final List<Post> post;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 35, bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_back),
                          )),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.settings),
                        )),
                  ],
                ),
                const Gap(10),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryColor, width: 2)
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.white, width: 2)
                        ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: widget.post[0].assignedTo.imageUrl,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
                const Gap(15),
                 CustomText(widget.post[0].assignedTo.name, fontWeight: FontWeight.w700, fontSize: 20,),
                const CustomText("basseysam84@gmail.com", color: Colors.grey,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primaryColor
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_reaction_outlined, color: Colors.white,),
                        Gap(5),
                        CustomText("Follow", fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white,)
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.white
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline_outlined, color: Colors.black,),
                        Gap(5),
                        CustomText("Message", fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.white
                    ),
                    child: const Column(
                      children: [
                        CustomText("9.7k", fontWeight: FontWeight.w700, fontSize: 22, color: Colors.black,),
                        CustomText("Followers", fontWeight: FontWeight.w500, color: Colors.grey,),
                      ],
                    ),
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.white
                    ),
                    child:  const Column(
                      children: [
                        CustomText("132k", fontWeight: FontWeight.w700, fontSize: 22, color: Colors.black,),
                        CustomText("Likes", fontWeight: FontWeight.w500, color: Colors.grey,),
                      ],
                    ),
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.white
                    ),
                    child: const Column(
                      children: [
                        CustomText("96k", fontWeight: FontWeight.w700, fontSize: 22, color: Colors.black,),
                        CustomText("Views", fontWeight: FontWeight.w500, color: Colors.grey,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Expanded(
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: AppColors.white,
                ),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: widget.post.length, // Number of items
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height:  200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(imageUrl: widget.post[index].imageUrl, fit: BoxFit.cover,)),
                    );
                  },
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
              )
          )
        ],
      ),
    );
  }

  double _getItemHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100.0;
      case 1:
      case 2:
        return 50.0;
      case 3:
        return 100.0;
      default:
        return 50.0; // Fallback in case of an unexpected value
    }
  }

  Color _getItemColor(int index) {
    return Colors.primaries[index % Colors.primaries.length]; // Different colors for each item
  }
}

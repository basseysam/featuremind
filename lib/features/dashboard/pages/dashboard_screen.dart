import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:featureminds/core/navigators/navigators.dart';
import 'package:featureminds/core/utils/app_colors.dart';
import 'package:featureminds/core/utils/app_strings.dart';
import 'package:featureminds/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import '../../../core/utils/constants.dart';
import '../../../core/widgets/comment_widget.dart';
import '../models/post_model.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key, required this.posts});
  final List<Post> posts;
  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  final CarouselController _controller = CarouselController();

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: double.maxFinite,
                margin: const EdgeInsets.only(left: 10, right: 10, top: 35, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.profile, arguments: widget.posts);
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(imageUrl: widget.posts[_current].assignedTo.imageUrl, height: 50, width: 50, fit: BoxFit.cover,)),
                        ),
                        const Gap(10),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(widget.posts[_current].assignedTo.name, fontWeight: FontWeight.w700, fontSize: 16,),
                            CustomText(formatTimestamp(widget.posts[_current].createdAt), color: Colors.grey,),
                          ],
                        )
                      ],
                    ),
                    const Gap(20),
                    Container(
                      height: 370,
                      width: double.maxFinite,
                      color: Colors.white,
                      child: CarouselSlider.builder(
                        itemCount: widget.posts.length,
                        carouselController: _controller,
                        itemBuilder: (context, index, realIndex) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, Routes.profile, arguments: widget.posts);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Stack(
                                children: [
                                  buildImage(widget.posts[index].imageUrl, index),
                                  Container(
                                        margin: const EdgeInsets.only(left: 10, top: 10),
                                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                        height: 190,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.black.withOpacity(0.3)
                                        ) ,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle
                                              ),
                                                child: const Icon(Icons.favorite,size: 30,)),
                                            const Gap(10),
                                            const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey,),
                                            const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white,),
                                            const Gap(10),
                                            Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration:  BoxDecoration(
                                                    color: Colors.black.withOpacity(0.3),
                                                    shape: BoxShape.circle
                                                ),
                                                child: const Icon(Icons.favorite,size: 30, color: Colors.white,)),
                                          ],
                                        ),
                                      ),
                                  Positioned(
                                    right: 10,
                                      top: 10,
                                      child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration:  BoxDecoration(
                                              color: Colors.black.withOpacity(0.3),
                                              shape: BoxShape.circle
                                          ),
                                          child:  Icon(
                                            widget.posts[_current].state == "in_progress" ?
                                            Icons.manage_accounts :
                                            widget.posts[_current].state == "complete" ?
                                            Icons.check : Icons.close,size: 30, color: Colors.white,)),
                                      const Gap(10),
                                      Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration:  BoxDecoration(
                                              color: Colors.black.withOpacity(0.3),
                                              shape: BoxShape.circle
                                          ),
                                          child: const Icon(Icons.messenger_outline,size: 30, color: Colors.white,)),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: double.maxFinite,
                          autoPlay: false,
                          viewportFraction: 1,
                          pauseAutoPlayOnTouch: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 20),
                        physics: const BouncingScrollPhysics(),
                        child: Wrap(
                          runSpacing: 10,
                          //direction: Axis.vertical,
                          children: List.generate(widget.posts[_current].comments.length, (index) {
                            return CommentWidget(comment:widget.posts[_current].comments[index] ,);
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: CachedNetworkImage(
      height: 370,
      width: double.maxFinite,
      imageUrl: urlImage,
      fit: BoxFit.cover,
    ),
  );
}





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:featureminds/core/utils/app_colors.dart';
import 'package:featureminds/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/navigators/route_names.dart';
import '../../dashboard/models/post_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _move(){
   Navigator.pushNamed(context, Routes.dashboard, arguments: _posts);
  }

final List<Post> _posts = [];

  Future fetchData() async {
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    QuerySnapshot querySnapshot = await posts.get();
    for (var doc in querySnapshot.docs) {
      _posts.add(Post.fromJson(doc.data() as Map<String, dynamic>));
    }
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData().then((value){
        Future.delayed(const Duration(milliseconds: 2000), _move);
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Lottie.asset(
            AppString.splashLottie,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width *.80,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

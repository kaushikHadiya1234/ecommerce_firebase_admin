import 'dart:async';

import 'package:ecommerce_firebase/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key? key}) : super(key: key);

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  bool? islogin;
  @override
  void initState() {
    super.initState();
   islogin =  FirebaseHelper.helper.checkuser();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () =>islogin==true?Get.offAllNamed('dash'):Get.offAllNamed('signin'));
    return SafeArea(child: Scaffold(
      body: Center(
        child: FlutterLogo(size: 20.h),
      ),
    ),);
  }
}

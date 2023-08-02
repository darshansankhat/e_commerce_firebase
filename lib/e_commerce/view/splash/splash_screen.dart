import 'package:e_commerce_firebase/e_commerce/view/helper_class/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool a= false;

  @override
  void initState() {
    super.initState();
     a = FirebaseHelper.firebaseHelper.checkUser();
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 5),() {
      if(a==true)
        {
          Get.offAllNamed("home");
          print("-----");
        }
      else
        {
          Get.offAllNamed("/");
        }
    },);

    return SafeArea(
      child: Scaffold(
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/s1.png",height: 200,width: 200),
            Image.asset("assets/images/s3.png",height: 100,color: Colors.deepOrange,),
            SizedBox(height: 2.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(backgroundColor: Colors.white,color: Colors.deepOrange,),
            ),
          ],
        )),
      ),
    );
  }
}

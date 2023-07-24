import 'package:e_commerce_firebase/e_commerce/view/helper_class/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
          Get.offAndToNamed("home");
          print("-----");
        }
      else
        {
          Get.offAndToNamed("/");
        }
    },);

    return SafeArea(
      child: Scaffold(
        body: Center(child: Image.asset("assets/images/s.png",height: 50,width: 200,)),
      ),
    );
  }
}

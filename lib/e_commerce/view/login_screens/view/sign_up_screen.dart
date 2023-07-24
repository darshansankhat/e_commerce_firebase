import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../helper_class/firebase_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //top
                Container(
                  height: 15.h,
                  width: 100.w,
                  alignment: Alignment.bottomLeft,
                  child: Text("Sign Up",style: TextStyle(fontSize: 35,color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                //name
                SizedBox(height: 10.h,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 2,offset: Offset(0,2))]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text("Name"),
                      ),
                    ),
                  ),
                ),
                //email
                SizedBox(height: 2.h,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 2,offset: Offset(0,2))]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: txtemail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text("Email"),
                      ),
                    ),
                  ),
                ),
                //password
                SizedBox(height: 2.h,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 2,offset: Offset(0,2))]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: txtpassword,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text("Password"),
                      ),
                    ),
                  ),
                ),
                //signup
                SizedBox(height: 5.h,),
                InkWell(
                  onTap: () async {
                    String msj = await FirebaseHelper.firebaseHelper.signUpEmail(txtemail.text, txtpassword.text);
                    if(msj=="SignUp Successfully")
                    {
                      Get.back();
                      Get.snackbar("", "$msj",colorText: Colors.black,backgroundColor: Colors.blue.shade50);
                    }
                    else
                    {
                      Get.snackbar("", "$msj",colorText: Colors.black,backgroundColor: Colors.blue.shade50);
                    }
                  },
                  child: Container(
                    height: 6.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.deepOrange,
                    ),
                    alignment: Alignment.center,
                    child: Text("Sign Up",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ),
                //sign up
                SizedBox(height: 24.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("All ready have account?",style: TextStyle(fontSize: 18),),
                    TextButton(onPressed: () {
                      Get.back();
                    }, child: Text("Sign In",style: TextStyle(fontSize: 18),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
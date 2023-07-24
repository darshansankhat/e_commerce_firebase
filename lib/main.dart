import 'package:e_commerce_firebase/e_commerce/view/add_product_screen/view/add_products_screen.dart';
import 'package:e_commerce_firebase/e_commerce/view/helper_class/notification_helper.dart';
import 'package:e_commerce_firebase/e_commerce/view/home_screen/view/home_screen.dart';
import 'package:e_commerce_firebase/e_commerce/view/login_screens/view/sign_in_screen.dart';
import 'package:e_commerce_firebase/e_commerce/view/login_screens/view/sign_up_screen.dart';
import 'package:e_commerce_firebase/e_commerce/view/splash/splash_screen.dart';
import 'package:e_commerce_firebase/e_commerce/view/updete_screen/view/updete_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationHelper.helper.initNotification();

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "splash",
        routes: {
          "/":(p0) => SignInScreen(),
          "splash":(p0) => SplashScreen(),
          "signup":(p0) => SignUpScreen(),
          "home":(p0) => HomeScreen(),
          "add":(p0) => AddProduct(),
          "update":(p0) => UpdeteProduct(),
        },
        theme: ThemeData(useMaterial3: true),
      ),
    ),
  );
}

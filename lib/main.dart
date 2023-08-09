import 'package:ecommerce_firebase/firebase_options.dart';
import 'package:ecommerce_firebase/home%20screen/View/add_product.dart';
import 'package:ecommerce_firebase/home%20screen/View/dash_screen.dart';
import 'package:ecommerce_firebase/login%20screen/View/sign_in_screen.dart';
import 'package:ecommerce_firebase/login%20screen/View/sign_up_screen.dart';
import 'package:ecommerce_firebase/login%20screen/View/splace_screen.dart';
import 'package:ecommerce_firebase/utils/firebase_helper.dart';
import 'package:ecommerce_firebase/utils/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  NotificationHelper.notificationHelper.initnotification();
  FirebaseHelper.helper.fireNotification();

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
         theme: ThemeData(useMaterial3: true),
         // initialRoute: 'signin',
        routes: {
           '/':(p0) =>SplaceScreen(),
          'dash':(p0) =>DashScreen(),
          'signin':(p0) =>SignInScreen(),
          'signup':(p0) =>SignUpScreen(),
          'add':(p0) =>AddProductScreen(),
        },
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second/views/screens/Delete_page.dart';
import 'package:second/views/screens/SignUp_Page.dart';
import 'package:second/views/screens/Upadate_page.dart';
import 'package:second/views/screens/all_user_page.dart';
import 'package:second/views/screens/forgot_page.dart';
import 'package:second/views/screens/forgot_pass.dart';
import 'package:second/views/screens/login_page.dart';
import 'package:second/views/screens/spelshscreens.dart';

void main() {
  runApp(
    GetMaterialApp(

      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => Splesh_screen()),
        GetPage(name: '/login_page', page: () => LoginForm()),
        GetPage(name: '/signup_page', page: () => SignupForm()),
        GetPage(name: '/all_user_page', page: () => All_User_Page()),
        GetPage(name: '/forgot_pass', page: () => Forgot_Pass()),
        GetPage(name: '/forgot_page', page: () => Forgot_Page()),
        GetPage(name: '/update_page', page: () => Update_Page()),
        // GetPage(name: '/delete_page', page: () => Delete_Page()),
      ],
    ),
  );
}

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Login with Signup',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginForm(),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_page.dart';

class Splesh_screen extends StatefulWidget {
  const Splesh_screen({Key? key}) : super(key: key);

  @override
  State<Splesh_screen> createState() => _Splesh_screenState();
}

class _Splesh_screenState extends State<Splesh_screen> {
  @override
  void initState() {
    super.initState();
    duration();
  }

  duration() async {
    await Future.delayed(
      Duration(seconds: 1),
      () {
        Get.off(LoginForm());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      Timer(Duration(seconds: 10),
          () => Navigator.of(context).pushReplacementNamed("login_page"));
    }

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(size: 150),
            SizedBox(height: 25),
            Text(
              'Demo Login App',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../comm/comHelper.dart';
import '../../comm/genTextFormField.dart';
import '../../helper/db_helper.dart';
import '../../models/UserModel.dart';
import 'forgot_page.dart';
import 'login_page.dart';
import 'package:get/get.dart';

class Forgot_Pass extends StatefulWidget {
  @override
  _Forgot_PassState createState() => _Forgot_PassState();
}

class _Forgot_PassState extends State<Forgot_Pass> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  forgot() async {
    String uid = _conUserId.text;
    // String passwd = _conPassword.text;

    if (uid.isEmpty) {
      alertDialog(context, "Please Enter User ID",Colors.red);
    }  else {
      await dbHelper.getForgotUser(uid).then((userData) {
        if (userData != null) {
          // alertDialog(context, "Error: User Not Found",Colors.red);
          setSP(userData).whenComplete(() {


            Get.to(Forgot_Page());
          });
        } else {
          alertDialog(context, "Error: User Not Found",Colors.red);
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail $error",Colors.red);
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                'Forgot Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.0),
                    FlutterLogo(size: 150),
                    SizedBox(height: 50),
                    getTextFormField(
                        controller: _conUserId,
                        icon: Icons.person,
                        hintName: 'User ID'),
                    SizedBox(height: 50),
                    Container(
                      margin:
                          EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
                      width: double.infinity,
                      child: TextButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: forgot,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    // Container(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text('Does you have account? '),
                    //       TextButton(
                    //         child: Text('Sign In'),
                    //         onPressed: () {
                    //           Get.off(LoginForm());
                    //         },
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Does you have account? ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none),
                  ),
                  TextButton(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none),
                    ),
                    onPressed: () {
                      Get.off(LoginForm());
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

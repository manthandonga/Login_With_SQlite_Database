import 'package:flutter/material.dart';
import 'package:second/views/screens/forgot_pass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../comm/comHelper.dart';
import '../../comm/genTextFormField.dart';
import '../../helper/db_helper.dart';
import '../../models/UserModel.dart';
import 'SignUp_Page.dart';
import 'all_user_page.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  // final _formKey = GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      alertDialog(context, "Please Enter User ID", Colors.red);
    } else if (passwd.isEmpty) {
      alertDialog(context, "Please Enter Password", Colors.red);
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {

            print('================================');
            // print('${DbHelper.data}')
            print('================================');
            Get.offAll(All_User_Page());
          });
        } else {
          alertDialog(context, "Enter correct password", Colors.red);
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail", Colors.red);
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

  Future<bool> showExitDialog() async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Exit app'),
              content: Text('Do you want to exit this app ?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('NO'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('YES'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Login',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            body: WillPopScope(
              onWillPop: showExitDialog,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 50.0),
                            FlutterLogo(
                              size: 150,
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                      getTextFormField(
                          controller: _conUserId,
                          icon: Icons.person,
                          hintName: 'User ID'),
                      SizedBox(height: 10.0),
                      // getTextFormField(
                      //   controller: _conPassword,
                      //   icon: Icons.lock,
                      //   hintName: 'Password',
                      //   isObscureText: true,
                      // ),
                      //=================================

                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Obx(
                            () => TextFormField(
                              controller: _conPassword,
                              obscureText: HomeController.isloginpasswordshow.value,
                              enabled: true,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      HomeController.isloginpasswordshow.value =
                                          !HomeController.isloginpasswordshow.value;
                                    },
                                    icon: Icon(
                                        (HomeController.isloginpasswordshow.value)
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                  )),
                            ),
                          )),

                      //=================================

                      // SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                child: Text('Forgot Password'),
                                onPressed: () {
                                  Get.to(Forgot_Pass());
                                })
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        width: double.infinity,
                        child: TextButton(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: login,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
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
                  'Does not have account? ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none),
                ),
                TextButton(
                  child: Text(
                    'Signup',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none),
                  ),
                  onPressed: () {
                    Get.to(SignupForm());
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

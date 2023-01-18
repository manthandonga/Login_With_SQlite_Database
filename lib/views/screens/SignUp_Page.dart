import 'package:flutter/material.dart';
import '../../comm/comHelper.dart';
import '../../comm/genTextFormField.dart';
import '../../controller/home_controller.dart';
import '../../helper/db_helper.dart';
import '../../models/UserModel.dart';
import 'login_page.dart';
import 'package:get/get.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (passwd != cpasswd) {
        alertDialog(context, 'Password Mismatch', Colors.red);
      }  else {
        _formKey.currentState?.save();

        UserModel uModel = UserModel(uid, uname, email, passwd);
        await dbHelper.saveData(uModel).then((userData) {
          alertDialog(context, "Successfully Saved", Colors.green);
          Get.off(LoginForm());
        }).catchError((error) {
          print(error);
          alertDialog(context, "User ID is invalid or already taken", Colors.red);
        });
      }
    }
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
                'Signup',
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
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        getTextFormField(
                            controller: _conUserId,
                            icon: Icons.person,
                            hintName: 'User ID'),
                        SizedBox(height: 10.0),
                        getTextFormField(
                            controller: _conUserName,
                            icon: Icons.person_outline,
                            inputType: TextInputType.name,
                            hintName: 'User Name'),
                        SizedBox(height: 10.0),
                        getTextFormField(
                            controller: _conEmail,
                            icon: Icons.email,
                            inputType: TextInputType.emailAddress,
                            hintName: 'Email'),
                        SizedBox(height: 10.0),


                        //============================
                        //password
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Obx(
                                  () => TextFormField(
                                controller: _conPassword,
                                obscureText: HomeController.ispasswordshow.value,
                                enabled: true,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Password';
                                  }
                                  if ('Password' == "Email" &&
                                      !validateEmail(value)) {
                                    return 'Please Enter Valid Email';
                                  }
                                  if ('Password' == "Confirm Password" &&
                                      "Password" == "Confirm Password") {
                                    return 'Password Mismatch';
                                  }
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
                                        HomeController.ispasswordshow.value =
                                        !HomeController.ispasswordshow.value;
                                      },
                                      icon: Icon(
                                          (HomeController.ispasswordshow.value)
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                    )),
                              ),
                            )),
                        //============================

                        SizedBox(height: 10.0),
                        //============================
                        //Confirm password
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Obx(
                                  () => TextFormField(
                                controller: _conCPassword,
                                obscureText: HomeController.iscpasswordshow.value,
                                enabled: true,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Confirm Password';
                                  }
                                  if (value != _conPassword.text) {
                                    return 'Password Mismatch';
                                  }
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
                                    hintText: 'Confirm Password',
                                    labelText: 'Confirm Password',
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        HomeController.iscpasswordshow.value =
                                        !HomeController.iscpasswordshow.value;
                                      },
                                      icon: Icon(
                                          (HomeController.iscpasswordshow.value)
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                    )),
                              ),
                            )),
                        //============================



                        // getTextFormField(
                        //   controller: _conPassword,
                        //   icon: Icons.lock,
                        //   hintName: 'Password',
                        //   isObscureText: true,
                        // ),

                        // getTextFormField(
                        //   controller: _conCPassword,
                        //   icon: Icons.lock,
                        //   hintName: 'Confirm Password',
                        //   isObscureText: true,
                        // ),
                        Container(
                          margin: EdgeInsets.all(30.0),
                          width: double.infinity,
                          child: TextButton(
                            child: Text(
                              'Signup',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: signUp,
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
                        //           Navigator.pushAndRemoveUntil(
                        //               context,
                        //               MaterialPageRoute(builder: (_) => LoginForm()),
                        //               (Route<dynamic> route) => false);
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
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:second/views/screens/all_user_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../comm/comHelper.dart';
// import '../../comm/genTextFormField.dart';
// import '../../helper/db_helper.dart';
// import 'login_page.dart';
// import 'package:get/get.dart';
//
// class Delete_Page extends StatefulWidget {
//   @override
//   _Delete_PageState createState() => _Delete_PageState();
// }
//
// class _Delete_PageState extends State<Delete_Page> {
//   final _formKey = new GlobalKey<FormState>();
//   Future<SharedPreferences> _pref = SharedPreferences.getInstance();
//
//   late DbHelper dbHelper;
//   final _conUserId = TextEditingController();
//   final _conDelUserId = TextEditingController();
//   final _conUserName = TextEditingController();
//   final _conEmail = TextEditingController();
//   final _conPassword = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//
//     dbHelper = DbHelper();
//   }
//
//   Future<void> getUserData() async {
//     final SharedPreferences sp = await _pref;
//
//     setState(() {
//       _conUserId.text = sp.getString("user_id")!;
//       _conDelUserId.text = sp.getString("user_id")!;
//       _conUserName.text = sp.getString("user_name")!;
//       _conEmail.text = sp.getString("email")!;
//       _conPassword.text = sp.getString("password")!;
//     });
//   }
//
//   delete() async {
//     String delUserID = _conDelUserId.text;
//
//     await dbHelper.deleteUser(delUserID).then((value) {
//       if (value == 1) {
//         alertDialog(context, "Successfully Deleted", Colors.red);
//         Get.offAll(All_User_Page());
//       }
//     });
//   }
//
//   showAlertDialog(BuildContext context) {
//     Widget cancelButton = TextButton(
//       child: Text("No"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//     Widget continueButton = TextButton(
//       child: Text("Yes"),
//       onPressed: delete,
//     );
//
//     AlertDialog alert = AlertDialog(
//       title: Text("Delete User"),
//       content: Text("Are You Sure This Account Was to Deleted ?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
//   static RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
//   data.add(await dbClient.rawQuery(query).obs as Map<String, dynamic>);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Delete User',
//           style: TextStyle(
//               fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_outlined,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             margin: EdgeInsets.only(top: 20.0),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   //Delete
//
//                   getTextFormField(
//                       controller: _conDelUserId,
//                       isEnable: false,
//                       icon: Icons.person,
//                       hintName: 'User ID'),
//                   SizedBox(height: 10.0),
//                   SizedBox(height: 10.0),
//                   Container(
//                     margin: EdgeInsets.all(30.0),
//                     width: double.infinity,
//                     child: TextButton(
//                       child: Text(
//                         'Delete',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         showAlertDialog(context);
//                       },
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

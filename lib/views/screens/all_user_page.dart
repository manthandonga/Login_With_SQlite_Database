// import 'package:flutter/material.dart';
// import 'package:second/views/screens/login_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../comm/comHelper.dart';
// import '../../helper/db_helper.dart';
// import 'Upadate_page.dart';
// import 'Delete_page.dart';
// import 'package:get/get.dart';
//
// class All_User_Page extends StatefulWidget {
//   const All_User_Page({Key? key}) : super(key: key);
//
//   @override
//   State<All_User_Page> createState() => _All_User_PageState();
// }
//
// class _All_User_PageState extends State<All_User_Page> {
//   late DbHelper dbHelper;
//
//   late Future<List<Map<String, dynamic>>> getAllData;
//
//
//   final _formKey = new GlobalKey<FormState>();
//
//   final _conUserId = TextEditingController();
//   final _conDelUserId = TextEditingController();
//   final _conUserName = TextEditingController();
//   final _conEmail = TextEditingController();
//   final _conPassword = TextEditingController();
//
//   Future<SharedPreferences> _pref = SharedPreferences.getInstance();
//
//   @override
//   void initState() {
//     super.initState();
//     dbHelper = DbHelper();
//     getAllData = dbHelper.fetchAllRecords();
//     print('$getAllData');
//     getUserData();
//   }
//
//   Future<bool> showExitDialog() async {
//     return await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Exit app'),
//           content: Text('Do you want to exit this app ?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//               child: Text('NO'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//               child: Text('YES'),
//             ),
//           ],
//         ));
//   }
//
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'All Login User',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             fontSize: 30,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (_) => LoginForm()),
//                     (Route<dynamic> route) => false);
//               },
//               icon: Icon(
//                 Icons.logout,
//                 color: Colors.black,
//               ))
//         ],
//       ),
//       backgroundColor: Colors.white,
//       body: WillPopScope(
//         onWillPop: showExitDialog,
//         child: FutureBuilder(
//           future: getAllData,
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text("ERROR :- ${snapshot.error}"),
//               );
//             } else if (snapshot.hasData) {
//               List<Map<String, dynamic>> data = snapshot.data!;
//               return ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (context, i) {
//                   return Card(
//                     elevation: 5,
//                     child: ListTile(
//
//                       leading: Text(
//                         "${i + 1}",
//                         style: TextStyle(color: Colors.black,fontSize: 25,),
//                         textAlign: TextAlign.center,
//                       ),
//                       title: Text(
//                         "User Id :- ${data[i]['user_id']}",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       subtitle: Text(
//                         "User Name :- ${data[i]['user_name']}\nEmail :- ${data[i]['email']}",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       trailing: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit,color: Colors.blue,),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (_) => Update_Page()),
//                               );
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                             onPressed: () {
//                               showAlertDialog(context);
//
//                             },
//                           )
//                         ],
//                       ),
//                       isThreeLine: true,
//                     ),
//                   );
//                   //   Card(
//                   //   elevation: 3,
//                   //   child: ListTile(
//                   //     leading: Text("${data[i]} + 1",style: TextStyle(color: Colors.black),),
//                   //     title: Text("${data[i]['user_id']}",style: TextStyle(color: Colors.black),),
//                   //     // subtitle: Text("${data[i]['email']}",style: TextStyle(color: Colors.black),),
//                   //     trailing: Row(
//                   //       children: [
//                   //         IconButton(
//                   //           icon: const Icon(Icons.edit),
//                   //           onPressed: () {
//                   //             Navigator.pushAndRemoveUntil(
//                   //                 context,
//                   //                 MaterialPageRoute(builder: (_) => HomeForm()),
//                   //                 (Route<dynamic> route) => false);
//                   //           },
//                   //         ),
//                   //         IconButton(
//                   //           icon: const Icon(
//                   //             Icons.delete,
//                   //             color: Colors.red,
//                   //           ),
//                   //           onPressed: () {},
//                   //         )
//                   //       ],
//                   //     ),
//                   //   ),
//                   // );
//                 },
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:second/views/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../comm/comHelper.dart';
import '../../helper/db_helper.dart';
import 'Upadate_page.dart';
import 'package:get/get.dart';

class All_User_Page extends StatefulWidget {
  const All_User_Page({Key? key}) : super(key: key);

  @override
  State<All_User_Page> createState() => _All_User_PageState();
}

class _All_User_PageState extends State<All_User_Page> {
  late DbHelper dbHelper;

  late Future<List<Map<String, dynamic>>> getAllData;


  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    getAllData = dbHelper.fetchAllRecords();
    print('$getAllData');
    getUserData();
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


  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserId.text = sp.getString("user_id")!;
      _conDelUserId.text = sp.getString("user_id")!;
      _conUserName.text = sp.getString("user_name")!;
      _conEmail.text = sp.getString("email")!;
      _conPassword.text = sp.getString("password")!;
    });
  }


  delete() async {
    String delUserID = _conDelUserId.text;

    await dbHelper.deleteUser(delUserID).then((value) {
      if (value == 1) {
        alertDialog(context, "Successfully Deleted", Colors.red);
        Get.offAll(All_User_Page());
      }
    });
  }


  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: delete,
    );

    AlertDialog alert = AlertDialog(
      title: Text("Delete User"),
      content: Text("Are You Sure This Account Was to Deleted ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Login User',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginForm()),
                        (Route<dynamic> route) => false);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: showExitDialog,
        child: FutureBuilder(
          future: getAllData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR :- ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 5,
                    child: ListTile(

                      leading: Text(
                        "${i + 1}",
                        style: TextStyle(color: Colors.black,fontSize: 25,),
                        textAlign: TextAlign.center,
                      ),
                      title: Text(
                        "User Id :- ${data[i]['user_id']}",
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        "User Name :- ${data[i]['user_name']}\nEmail :- ${data[i]['email']}",
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit,color: Colors.blue,),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Update_Page()),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showAlertDialog(context);

                            },
                          )
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                  //   Card(
                  //   elevation: 3,
                  //   child: ListTile(
                  //     leading: Text("${data[i]} + 1",style: TextStyle(color: Colors.black),),
                  //     title: Text("${data[i]['user_id']}",style: TextStyle(color: Colors.black),),
                  //     // subtitle: Text("${data[i]['email']}",style: TextStyle(color: Colors.black),),
                  //     trailing: Row(
                  //       children: [
                  //         IconButton(
                  //           icon: const Icon(Icons.edit),
                  //           onPressed: () {
                  //             Navigator.pushAndRemoveUntil(
                  //                 context,
                  //                 MaterialPageRoute(builder: (_) => HomeForm()),
                  //                 (Route<dynamic> route) => false);
                  //           },
                  //         ),
                  //         IconButton(
                  //           icon: const Icon(
                  //             Icons.delete,
                  //             color: Colors.red,
                  //           ),
                  //           onPressed: () {},
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

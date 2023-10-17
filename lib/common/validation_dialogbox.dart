import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:http/http.dart' as http;

import '../constants/storage_manager.dart';

class WarningDialogBox extends StatefulWidget {
  /// Creates a widget combines of  [Container].
  /// [title], [descriptions], [onPressed] must not be null.
  ///
  /// This widget will return dialog to show warning.
  /// For e.g. when user tap on report user icon will show [WarningDialogBox] to warn user about the action.
  const WarningDialogBox({
    Key? key,
    required this.title,
    required this.icon,
    required this.descriptions,
    required this.buttonTitle,
    required this.onPressed,
    this.buttonColor = AppColors.app_color,
  }) : super(key: key);

  final String title, descriptions, buttonTitle;
  final Color buttonColor;
  final IconData icon;
  final Function() onPressed;

  @override
  _WarningDialogBoxState createState() => _WarningDialogBoxState();
}

class _WarningDialogBoxState extends State<WarningDialogBox> {
  @override
  Widget build(BuildContext context) {
    // final w = MediaQuery.of(context).size.width;
    // final h = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  Stack contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          // width: 350,
          child: Column(
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.02,
              // ),
              // Container(
              //   height: 40,
              //   width: 40,
              //   decoration:
              //       BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              //   child: Icon(widget.icon, color: Colors.white),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(widget.title,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                      )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(widget.descriptions,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                        )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // FutureBuilder(
                  //     future: DeletePoatApi(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         return InkWell(
                  //           onTap: widget.onPressed,
                  //           child: Container(
                  //             height: MediaQuery.of(context).size.height * 0.05,
                  //             width: MediaQuery.of(context).size.width * 0.3,
                  //             decoration: BoxDecoration(
                  //                 color: widget.buttonColor,
                  //                 borderRadius: BorderRadius.circular(30)),
                  //             child: Center(
                  //               child: Text(widget.buttonTitle,
                  //                   style: TextStyle(
                  //                       fontSize: 12.sp,
                  //                       color: Colors.white,
                  //                       fontFamily: "Montserrat-Medium")),
                  //             ),
                  //           ),
                  //         );
                  //       }
                  //       return Center();
                  //     }),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.055,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(17)),
                      child: Center(
                        child: Text("No",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: widget.onPressed,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.055,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          color: widget.buttonColor,
                          borderRadius: BorderRadius.circular(17)),
                      child: Center(
                        child: Text(widget.buttonTitle,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                               )),
                      ),
                    ),
                  ),

                  // InkWell(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.height * 0.05,
                  //     width: MediaQuery.of(context).size.width * 0.3,
                  //     decoration: BoxDecoration(
                  //         color: Colors.white38,

                  //         border: Border.all(color: Colors.black),
                  //         borderRadius: BorderRadius.circular(30)),
                  //     child: Center(
                  //       child: Text("Cancel",
                  //           style: TextStyle(
                  //               fontSize: 12.sp,
                  //               color: Colors.black,
                  //               fontFamily: "Montserrat-Medium")),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  late Map<String, dynamic> PromapResponse;
  late Map<String, dynamic> ProlistResponse = {};

  Future<Map<String, dynamic>> DeletePoatApi() async {
    //  const url = '${Constants.BASE_URL}api/wallet/serviceprovider/stats';
    final token = StorageManager().accessToken;
    final int userID = StorageManager().userId;
    const url = 'https://urbanmalta.com/api/user/deleteaccount';
    // final token = '1336|OGWrOCFWZUHYNAWPaTPM28yKOLSQElcLzE5HPe2g';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'user_id': userID.toString(),
    };

    final jsonBody = json.encode(body);

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        print('API request successful');

        setState(() {
          PromapResponse = json.decode(response.body);
          ProlistResponse = PromapResponse['data'];

          print(ProlistResponse);
        });
        return ProlistResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch data');
    }
  }
}



// class DeletePopUp extends StatefulWidget {
//   const DeletePopUp({Key? key}) : super(key: key);

//   @override
//   State<DeletePopUp> createState() => _DeletePopUpState();
// }

// class _DeletePopUpState extends State<DeletePopUp> {
//   @override
//   Widget build(BuildContext context) {
//         final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return  Dialog(
//        shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0)),
      // child: Container(
      //     height: h * 0.28,
      //     // width: 350,
      //     child: 
      //     Column(
      //       children: [
      //         SizedBox(
      //           height: h * 0.02,
      //         ),

      //         Container(
      //           height: 40,
      //           width: 40,
      //           decoration: BoxDecoration(
      //             color: Colors.red,
      //             shape: BoxShape.circle

      //           ),
      //           child: Icon(Icons.close , color: Colors.white ,),
      //         ),
      //          SizedBox(
      //           height: h * 0.015,
      //         ),
      //          Text("Delete Item",
      //                   style: TextStyle(
      //                       fontSize: 15.sp,
      //                       color: Colors.black,
      //                       fontFamily: "Montserrat-Medium")),
      //                        SizedBox(
      //           height: h * 0.015,
      //         ),
      //          Text("Do you want to delete this job",
      //                   style: TextStyle(
      //                       fontSize: 12.sp,
      //                       color: Colors.black,
      //                       fontFamily: "Montserrat-Light")),
      //                        SizedBox(
      //           height: h * 0.035,
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             InkWell(
      //               onTap: (){
      //                 Navigator.pop(context);
      //               },
      //               child: Container(
      //                 height: h * 0.05,
      //                 width:  w * 0.3,
      //                    decoration: BoxDecoration(
      //               color: Colors.red,
      //                              borderRadius: BorderRadius.circular(30)
      //                             ),
      //                             child: Center(
      //               child: Text("Delete",
      //                       style: TextStyle(
      //                           fontSize: 12.sp,
      //                           color: Colors.white,
      //                           fontFamily: "Montserrat-Medium")),
      //                             ),
                     
                  
      //               ),
      //             ),
      //              InkWell(
      //               onTap: (){
      //                 Navigator.pop(context);
      //               },
      //               child: Container(
      //                 height: h * 0.05,
      //                 width:  w * 0.3,
      //                    decoration: BoxDecoration(
      //               color: Colors.black,
      //                              borderRadius: BorderRadius.circular(30)
      //                             ),
      //                             child: Center(
      //               child: Text("Cancel",
      //                       style: TextStyle(
      //                           fontSize: 12.sp,
      //                           color: Colors.white,
      //                           fontFamily: "Montserrat-Medium")),
      //                             ),
                     
                  
      //               ),
      //             ),
                  
      //           ],
      //         )





              


      //       ],
      //     ),
      //   ),
//     );
  
//   }
// }
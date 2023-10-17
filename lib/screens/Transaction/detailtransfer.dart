// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // // import 'package:my_app/transaction.dart';
// // import 'package:http/http.dart'as http;
// // import 'package:my_app/Transaction/topup.dart';

// // class SlideUpPage extends StatefulWidget {
// //   @override
// //   _SlideUpPageState createState() => _SlideUpPageState();
// // }

// // class _SlideUpPageState extends State<SlideUpPage>
// //     with SingleTickerProviderStateMixin {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           Container(
// //             height: 669,
// //             width: double.infinity,
// //             decoration: BoxDecoration(
// //                 color: Color(0xfff6f8ff),
// //                 borderRadius: BorderRadius.circular(40)),
// //             child: Column(
// //               children: [
// //                 const SizedBox(
// //                   width: 40,
// //                   child: Column(
// //                     children: [
// //                       SizedBox(
// //                         width: 15,
// //                         child: Divider(
// //                           color: Colors.grey,
// //                         ),
// //                       ),
// //                       SizedBox(
// //                         width: 40,
// //                         child: Divider(
// //                           color: Colors.grey,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 const Text(
// //                   "Detail Transaction",
// //                   style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w700,
// //                       color: Color(0xff161D35)),
// //                 ),
// //                 const SizedBox(
// //                   height: 15,
// //                 ),
// //                 Stack(
// //                   alignment: Alignment.topCenter,
// //                   children: [
// //                     Padding(
// //                       padding: EdgeInsets.only(top: 30),
// //                       child: Container(
// //                         height: 230,
// //                         width: 340,
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                               color: Color(0xffffffff),
// //                               borderRadius: BorderRadius.circular(20)),
// //                         ),
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         Navigator.push(context,
// //                             MaterialPageRoute(builder: (context) {
// //                           return TopUp();
// //                         }));
// //                       },
// //                       child: const CircleAvatar(
// //                         backgroundColor: Color(0xff4995eb),
// //                         radius: 30,
// //                         child: Icon(
// //                           Icons.check,
// //                           color: Colors.white,
// //                           size: 50,
// //                         ),
// //                       ),
// //                     ),
// //                     const Padding(
// //                         padding: EdgeInsets.only(top: 80),
// //                         child: Column(
// //                           children: [
// //                             Text(
// //                               "Top Up",
// //                               style: TextStyle(
// //                                   fontSize: 18,
// //                                   fontWeight: FontWeight.w600,
// //                                   color: Colors.black),
// //                             ),
// //                             SizedBox(
// //                               height: 5,
// //                             ),
// //                             Text(
// //                               "You did a top up from Apple Pay",
// //                               style: TextStyle(
// //                                   fontSize: 15,
// //                                   fontWeight: FontWeight.w400,
// //                                   color: Colors.black),
// //                             ),
// //                             SizedBox(
// //                               height: 25,
// //                             ),
// //                             Text(
// //                               "You added a sum",
// //                               style: TextStyle(
// //                                   fontSize: 15,
// //                                   fontWeight: FontWeight.w400,
// //                                   color: Color(0xff6B769B)),
// //                             ),
// //                             SizedBox(
// //                               height: 5,
// //                             ),
// //                             Text(
// //                               "€ 199",
// //                               style: TextStyle(
// //                                   fontSize: 22,
// //                                   fontWeight: FontWeight.w700,
// //                                   color: Color(0xff161D35)),
// //                             ),
// //                             SizedBox(
// //                               height: 5,
// //                             ),
// //                             Text(
// //                               "Jun 16, 2020",
// //                               style: TextStyle(
// //                                   fontSize: 15,
// //                                   fontWeight: FontWeight.w700,
// //                                   color: Color(0xff6B769B)),
// //                             ),
// //                           ],
// //                         )),
// //                   ],
// //                 ),
// //                 const SizedBox(
// //                   height: 40,
// //                 ),
// //                 Container(
// //                   height: 230,
// //                   width: 340,
// //                   decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(20)),
// //                   child: Column(
// //                     children: [
// //                       const SizedBox(
// //                         height: 20,
// //                       ),
// //                       const Text(
// //                         "Summary",
// //                         style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.w700,
// //                             color: Color(0xff000000)),
// //                       ),
// //                       const SizedBox(
// //                         height: 10,
// //                       ),
// //                       Container(
// //                         width: 300,
// //                         child: const Divider(
// //                           thickness: 0.6,
// //                         ),
// //                       ),
// //                       const SizedBox(
// //                         height: 10,
// //                       ),
// //                       Container(
// //                           padding: EdgeInsets.only(right: 20, left: 20),
// //                           child: const Row(
// //                             mainAxisAlignment:
// //                                 MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 "Total",
// //                                 style: TextStyle(
// //                                     fontSize: 15,
// //                                     fontWeight: FontWeight.w500,
// //                                     color: Color(0xff000000)),
// //                               ),
// //                               Text(
// //                                 "€ 10",
// //                                 style: TextStyle(
// //                                     fontSize: 15,
// //                                     fontWeight: FontWeight.w500,
// //                                     color: Color(0xff000000)),
// //                               )
// //                             ],
// //                           )),
// //                       const SizedBox(
// //                         height: 30,
// //                       ),
// //                       Container(
// //                         width: 300,
// //                         child: const Divider(
// //                           thickness: 0.6,
// //                         ),
// //                       ),
// //                       const SizedBox(
// //                         height: 10,
// //                       ),
// //                       Container(
// //                           padding: EdgeInsets.only(right: 20, left: 20),
// //                           child: const Row(
// //                             mainAxisAlignment:
// //                                 MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 "Total Fee",
// //                                 style: TextStyle(
// //                                     fontSize: 15,
// //                                     fontWeight: FontWeight.w500,
// //                                     color: Color(0xff000000)),
// //                               ),
// //                               Text(
// //                                 "€ 10",
// //                                 style: TextStyle(
// //                                     fontSize: 15,
// //                                     fontWeight: FontWeight.w500,
// //                                     color: Color(0xff000000)),
// //                               )
// //                             ],
// //                           )),
// //                     ],
// //                   ),
// //                 )
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }

// //   late String stringResponse;
// //   late Map mapResponse;
// //   late Map dataResponse;
// //   late List listResponse;

// //   Future<List<dynamic>> DpostDataWithToken() async {
// //     final url = 'https://urbanmalta.com/api/wallet/details';
// //     String token =
// //         '945|zYVmAkQAKvnngMMBJPWHNJRkti9pdwHYmwxsH0TA'; // Replace 'your_token_here' with your actual token

// //     final headers = {
// //       'Content-Type': 'application/json',
// //       'Authorization': 'Bearer $token',
// //     };

// //     final body = {
// //       'user_id': '23',
// //       'id': '7',
// //     };

// //     final jsonBody = json.encode(body);

// //     try {
// //       final response =
// //           await http.post(Uri.parse(url), headers: headers, body: jsonBody);

// //       if (response.statusCode == 200) {
// //         print('API request successful');
// //         print(response);
// //         setState(() {
// //           mapResponse = json.decode(response.body);
// //           listResponse = mapResponse['data'];
// //           print(listResponse);
// //         });
// //         return listResponse;
// //       } else {
// //         throw Exception('Failed to fetch data');
// //       }
// //     } catch (error) {
// //       throw Exception('Failed to fetch data');
// //     }
// //   }
// // }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/constants/constants.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/Transaction/topup.dart';

class SlideUpPage extends StatefulWidget {
  @override
  _SlideUpPageState createState() => _SlideUpPageState();
}

class _SlideUpPageState extends State<SlideUpPage> {
  late String DstringResponse;
  late Map<String, dynamic> DmapResponse;
  late List<dynamic> DlistResponse;

  Future<List<dynamic>> DpostDataWithToken() async {
    final url = '${Constants.BASE_URL}/api/wallet/details';
    final token = StorageManager().accessToken;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'user_id': StorageManager().userId,
      'id': '7',
    };

    final jsonBody = json.encode(body);

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        print('API request successful');
        print(response);
        setState(() {
          DmapResponse = json.decode(response.body);
          DlistResponse = DmapResponse['data'];
          print(DlistResponse);
        });
        return DlistResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.83,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xfff6f8ff),
              borderRadius: BorderRadius.circular(40),
            ),
            child: FutureBuilder(
                future: DpostDataWithToken(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // final data = snapshot.data!;
                    // String createdAt = DlistResponse[0]['date'].toString();
                    // DateTime dateTime = DateTime.parse(createdAt);

                    // String formattedDate =
                    //     "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                    return Column(
                      children: [
                         SizedBox(
                          width: 40,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 15,
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "Detail Transaction",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff161D35),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Container(
                                height: 230,
                                width: 340,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return TopUp();
                                }));
                              },
                              child: const CircleAvatar(
                                backgroundColor: Color(0xff4995eb),
                                radius: 30,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 80),
                              child:  Column(
                                children: [
                              const    Text(
                                    'title',

                                    // "af",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "You did a top up from Apple Pay",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'desc',
                                    // 'asd',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff6B769B),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "€ ",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff161D35),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'formattedDate',
                                    // '345',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff6B769B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 230,
                          width: 340,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Summary",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff000000),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 300,
                                child: const Divider(
                                  thickness: 0.6,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Text(
                                      "€ 'amount']}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 300,
                                child: const Divider(
                                  thickness: 0.6,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Fee",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Text(
                                      "€ DlistResponse[0]['amount']}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

// ///////////////////////
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:my_app/Transaction/topup.dart';

// class SlideUpPage extends StatefulWidget {
//   @override
//   _SlideUpPageState createState() => _SlideUpPageState();
// }

// class _SlideUpPageState extends State<SlideUpPage> {
//   late String DstringResponse;
//   late Map<String, dynamic> DmapResponse;
//   late List<dynamic> DlistResponse;

//   Future<List<dynamic>> DpostDataWithToken() async {
//     final url = 'https://urbanmalta.com/api/wallet/details';
//     final token = '955|VhZqPiSNUbf5s8vumndq91W0bzoTvyJkyDcVEEmP';

//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };

//     final body = {
//       'user_id': '181',
//       'id': '7',
//     };

//     final jsonBody = json.encode(body);

//     try {
//       final response =
//           await http.post(Uri.parse(url), headers: headers, body: jsonBody);

//       if (response.statusCode == 200) {
//         print('API request successful');
//         print(response);
//         setState(() {
//           DmapResponse = json.decode(response.body);
//           DlistResponse = DmapResponse['data'];
//           print(DlistResponse);
//         });
//         return DlistResponse;
//       } else {
//         throw Exception('Failed to fetch data');
//       }
//     } catch (error) {
//       print(error);
//       throw Exception('Failed to fetch data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.9,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Color(0xfff6f8ff),
//               borderRadius: BorderRadius.circular(40),
//             ),
//             child: FutureBuilder(
//               future: DpostDataWithToken(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     children: [
//                       const SizedBox(
//                         width: 40,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               width: 15,
//                               child: Divider(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 40,
//                               child: Divider(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Text(
//                         "Detail Transaction",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xff161D35),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Stack(
//                         alignment: Alignment.topCenter,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(top: 30),
//                             child: Container(
//                               height: 230,
//                               width: 340,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Color(0xffffffff),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) {
//                                 return TopUp();
//                               }));
//                             },
//                             child: const CircleAvatar(
//                               backgroundColor: Color(0xff4995eb),
//                               radius: 30,
//                               child: Icon(
//                                 Icons.check,
//                                 color: Colors.white,
//                                 size: 50,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 80),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   'title',
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 const Text(
//                                   "You did a top up from Apple Pay",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 25,
//                                 ),
//                                 Text(
//                                   'desc',
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff6B769B),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "€ ",
//                                   style: const TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w700,
//                                     color: Color(0xff161D35),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   'formattedDate',
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w700,
//                                     color: Color(0xff6B769B),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       Container(
//                         height: 230,
//                         width: 340,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Column(
//                           children: [
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             const Text(
//                               "Summary",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xff000000),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               width: 300,
//                               child: const Divider(
//                                 thickness: 0.6,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Total",
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xff000000),
//                                     ),
//                                   ),
//                                   Text(
//                                     "€ 'amount']}",
//                                     style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xff000000),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 30,
//                             ),
//                             Container(
//                               width: 300,
//                               child: const Divider(
//                                 thickness: 0.6,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Total Fee",
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xff000000),
//                                     ),
//                                   ),
//                                   Text(
//                                     "€ 'amount']}",
//                                     style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xff000000),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

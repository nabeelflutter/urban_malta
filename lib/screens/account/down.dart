// // import 'dart:convert';

// import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// class SlidingUperPage extends StatefulWidget {
//   @override
//   _SlidingUperPageState createState() => _SlidingUperPageState();
// }

// class _SlidingUperPageState extends State<SlidingUperPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//               height: 669,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Color(0xfff6f8ff),
//                 borderRadius: BorderRadius.circular(40),
//               ),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     width: 40,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           width: 15,
//                           child: Divider(
//                             color: Colors.grey,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 40,
//                           child: Divider(
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Text(
//                     "Detail Transaction",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xff161D35),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Stack(
//                     alignment: Alignment.topCenter,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(top: 30),
//                         child: Container(
//                           height: 230,
//                           width: 340,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Color(0xffffffff),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         child: const CircleAvatar(
//                           backgroundColor: Color(0xff4995eb),
//                           radius: 30,
//                           child: Icon(
//                             Icons.check,
//                             color: Colors.white,
//                             size: 50,
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(top: 80),
//                         child: Column(
//                           children: [
//                             Text(
//                               'Tittle',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "You did a top up from Apple Pay",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 25,
//                             ),
//                             Text(
//                               'DlistResponse',
//                               // 'asd',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xff6B769B),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               '33',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xff161D35),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               'formattedDate',
//                               // '345',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xff6B769B),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   Container(
//                     height: 230,
//                     width: 340,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         const Text(
//                           "Summary",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             color: Color(0xff000000),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           width: 300,
//                           child: const Divider(
//                             thickness: 0.6,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 20, left: 20),
//                           child: const Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Total",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xff000000),
//                                 ),
//                               ),
//                               Text(
//                                 'asdfg',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xff000000),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Container(
//                           width: 300,
//                           child: const Divider(
//                             thickness: 0.6,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 20, left: 20),
//                           child: const Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Total Fee",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xff000000),
//                                 ),
//                               ),
//                               Text(
//                                 "€",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xff000000),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )),
//         ],
//       ),
//     );
//   }
// }

/////////////////////
///
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SlidingUperPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String iban;
  final String amount;
  final bool success;

  const SlidingUperPage(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.iban,
      required this.amount,
      required this.success})
      : super(key: key);
  @override
  _SlidingUperPageState createState() => _SlidingUperPageState();
}

class _SlidingUperPageState extends State<SlidingUperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xfff6f8ff),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
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
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
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
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        children: [
                          Text(
                            widget.success == 200 ? 'Transfer' : "Fail",
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
                          const Text(
                            'You transfered a sum',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6B769B),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '€${widget.amount}',
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
                            " ${DateFormat("dd MMMM, yyyy HH:mm").format(DateTime.now())}",
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
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.9,
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                              ),
                            ),
                            Text(
                              'asdfg',
                              style: TextStyle(
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Fee",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                              ),
                            ),
                            Text(
                              "€",
                              style: TextStyle(
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
            ),
          ),
        ],
      ),
    );
  }
}

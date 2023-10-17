// import 'package:flutter/material.dart';
// import 'package:my_app/Transaction/statisic.dart';
// import 'package:my_app/homescreen/gig.dart';

// class HomeScreenFirst extends StatefulWidget {
//   const HomeScreenFirst({super.key});

//   @override
//   State<HomeScreenFirst> createState() => _HomeScreenFirstState();
// }

// class _HomeScreenFirstState extends State<HomeScreenFirst> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.only(top: 65, left: 20, right: 20),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   height: 40,
//                   width: 130,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Color(0xfff1f6fb)),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Icon(
//                         Icons.location_on,
//                         color: Colors.blue,
//                       ),
//                       Text(
//                         'City Name',
//                         style:
//                             TextStyle(fontSize: 14, color: Color(0xff8189B0)),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 40,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                           width: 40,
//                           decoration: BoxDecoration(
//                               border:
//                                   Border.all(width: 0.5, color: Colors.grey),
//                               borderRadius: BorderRadius.circular(5)),
//                           child: IconButton(
//                               onPressed: () {},
//                               icon: const Icon(
//                                 Icons.notifications,
//                                 color: Colors.grey,
//                               ))),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(width: 0.5, color: Colors.grey)),
//                         child: Image.asset('assets/images/j13.png'),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Column(
//               children: [
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         child: const Text(
//                           'Hello, User Name!',
//                           style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.w800,
//                               color: Color(0xff2E3E5C)),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         child: const Text(
//                           'Ready to Showcase ',
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff2E3E5C)),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         child: const Text(
//                           'Your Skills?',
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff2E3E5C)),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         child: const Text(
//                           'Your Balance : €47',
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff2E3E5C)),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         child: const Text(
//                           'Overall Rating:',
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff2E3E5C)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 SizedBox(
//                   height: 515,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (context) {
//                                   return Statistic();
//                                 }));
//                               },
//                               child: Container(
//                                 height: 190,
//                                 width: 160,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: Color(0xffF1F6FB)),
//                                 child: Column(
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/j19.png',
//                                       height: 160,
//                                     ),
//                                     const Text(
//                                       'Statistics',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           color: Color(0xff7F8E9D)),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 190,
//                               width: 160,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: Color(0xffF1F6FB)),
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/j20.png',
//                                     height: 160,
//                                   ),
//                                   const Text(
//                                     'Create A GiG',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff7F8E9D)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         //   ],
//                         // ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (context) {
//                                   return Gigs();
//                                 }));
//                               },
//                               child: Container(
//                                 height: 190,
//                                 width: 160,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: Color(0xffF1F6FB)),
//                                 child: Column(
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/j21.png',
//                                       height: 160,
//                                     ),
//                                     const Text(
//                                       'Check Your GiGs',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           color: Color(0xff7F8E9D)),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 190,
//                               width: 160,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: Color(0xffF1F6FB)),
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/j22.png',
//                                     height: 160,
//                                   ),
//                                   const Text(
//                                     'Ratings and Reviews',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff7F8E9D)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               height: 65,
//                               width: 170,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Color(0xffDEE7FF)),
//                               child: const Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     '€47',
//                                     style: TextStyle(
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff3B6DF1)),
//                                   ),
//                                   Text(
//                                     'Personal Balance',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff7F8E9D)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 65,
//                               width: 170,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Color(0xffD0F6E8)),
//                               child: const Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     '10',
//                                     style: TextStyle(
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff21B882)),
//                                   ),
//                                   Text(
//                                     'Total Bookings',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff7F8E9D)),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               height: 65,
//                               width: 170,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Color(0xffF6DFCF)),
//                               child: const Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     '€47',
//                                     style: TextStyle(
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff3B6DF1)),
//                                   ),
//                                   Text(
//                                     'Earning This Month',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff7F8E9D)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 65,
//                               width: 170,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Color(0xffFFD5E9)),
//                               child: const Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     '€10',
//                                     style: TextStyle(
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff21B882)),
//                                   ),
//                                   Text(
//                                     'Payment On Hold',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff7F8E9D)),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

////////////////////////////
///
///

import 'package:flutter/material.dart';

import '../Transaction/statisic.dart';
import 'gig.dart';

class HomeScreenFirst extends StatefulWidget {
  const HomeScreenFirst({Key? key}) : super(key: key);

  @override
  State<HomeScreenFirst> createState() => _HomeScreenFirstState();
}

class _HomeScreenFirstState extends State<HomeScreenFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 65, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xfff1f6fb),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.location_on,

                        /// y h
                        color: Colors.blue,
                      ),
                      Text(
                        'City Name',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff8189B0)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5, color: Colors.grey),
                        ),
                        child: Image.asset('assets/images/j13.png'),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Hello, User Name!',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xff2E3E5C),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Ready to Showcase',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff2E3E5C),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Your Skills?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff2E3E5C),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Your Balance : €47',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff2E3E5C),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Overall Rating:',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff2E3E5C),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return Statistic();
                                    }),
                                  );
                                },
                                child: Container(
                                  height: 190,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffF1F6FB),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/j19.png',
                                        height: 160,
                                      ),
                                      const Text(
                                        'Statistics',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff7F8E9D),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 190,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffF1F6FB),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/j20.png',
                                      height: 160,
                                    ),
                                    const Text(
                                      'Create A GiG',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff7F8E9D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return Gigs();
                                    }),
                                  );
                                },
                                child: Container(
                                  height: 190,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffF1F6FB),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/j21.png',
                                        height: 160,
                                      ),
                                      const Text(
                                        'Check Your GiGs',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff7F8E9D),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 190,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffF1F6FB),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/j22.png',
                                      height: 160,
                                    ),
                                    const Text(
                                      'Ratings and Reviews',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff7F8E9D),
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
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              Container(
                                height: 65,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffDEE7FF),
                                ),
                                child:  Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '€47',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff3B6DF1),
                                      ),
                                    ),
                                    Text(
                                      'Personal Balance',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff7F8E9D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 65,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffD0F6E8),
                                ),
                                child:  Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '10',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff21B882),
                                      ),
                                    ),
                                    Text(
                                      'Total Bookings',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff7F8E9D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 65,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffF6DFCF),
                                ),
                                child:  Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '€47',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff3B6DF1),
                                      ),
                                    ),
                                    Text(
                                      'Earning This Month',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff7F8E9D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 65,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffFFD5E9),
                                ),
                                child:  Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '€10',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff21B882),
                                      ),
                                    ),
                                    Text(
                                      'Payment On Hold',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff7F8E9D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

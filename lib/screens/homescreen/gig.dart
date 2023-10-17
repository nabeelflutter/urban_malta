// import 'package:flutter/material.dart';

// class Gigs extends StatefulWidget {
//   const Gigs({super.key});

//   @override
//   State<Gigs> createState() => _GigsState();
// }

// class _GigsState extends State<Gigs> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff2f7fd),
//       appBar: AppBar(
//         backgroundColor: Color(0xffffffff),

//         title: const Text(
//           'Your GIGs',
//           style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.w700,
//               color: Color(0xff2E3E5C)),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Container(
//         padding: EdgeInsets.only(top: 15, left: 15, right: 15),
//         child: ListView.builder(
//             itemCount: 5,
//             itemBuilder: (BuildContext context, int index) {
//               return Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(right: 10),
//                     height: 150,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 150,
//                           width: 150,
//                           child: Image.asset(
//                             'assets/images/j14.png',
//                             height: 140,
//                             width: 160,
//                             fit: BoxFit.fitHeight,
//                           ),
//                         ),
//                         Container(
//                           height: 140,
//                           width: 180,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               const Text(
//                                 'I will provice you house cleaning service',
//                                 style: TextStyle(
//                                     fontSize: 15, color: Color(0xff7B7D83)),
//                               ),
//                               Container(
//                                 alignment: Alignment.centerLeft,
//                                 child: const Row(
//                                   children: [
//                                     Text(
//                                       '4.5',
//                                       style: TextStyle(
//                                           color: Color(0xffF79E1F),
//                                           fontSize: 15),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       '(125 Rating) ',
//                                       style: TextStyle(
//                                           color: Color(0xff7B7D83),
//                                           fontSize: 15),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               const Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Hourly Price',
//                                     style: TextStyle(
//                                         fontSize: 15, color: Color(0xff161616)),
//                                   ),
//                                   Text(
//                                     '€10',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         color: Color(0xff161616),
//                                         fontWeight: FontWeight.w700),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   )
//                 ],
//               );
//             }),
//       ),
//     );
//   }
// }

///////////////////////////////////
///
///
///
import 'package:flutter/material.dart';

class Gigs extends StatefulWidget {
  const Gigs({Key? key});

  @override
  State<Gigs> createState() => _GigsState();
}

class _GigsState extends State<Gigs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f7fd),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: const Text(
          'Your GIGs',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color(0xff2E3E5C),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10),
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double imageWidth = constraints.maxWidth * 0.35;
                      double imageHeight = constraints.maxHeight * 0.9;
                      double infoWidth = constraints.maxWidth * 0.55;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: imageWidth,
                            child: Image.asset(
                              'assets/images/j14.png',
                              height: imageHeight,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Container(
                            width: infoWidth,
                            child:   Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 Text(
                                  'I will provide you house cleaning service',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff7B7D83),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '4.5',
                                      style: TextStyle(
                                        color: Color(0xffF79E1F),
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '(125 Rating)',
                                      style: TextStyle(
                                        color: Color(0xff7B7D83),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hourly Price',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff161616),
                                      ),
                                    ),
                                    Text(
                                      '€10',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff161616),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 15),
              ],
            );
          },
        ),
      ),
    );
  }
}

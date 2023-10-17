// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../constants/storage_manager.dart';
// import '../notification/notification_screen.dart';

// class Homescreen2 extends StatefulWidget {
//   final Map<String, dynamic> jsonData;

//   const Homescreen2({Key? key, required this.jsonData}) : super(key: key);

//   @override
//   State<Homescreen2> createState() => _Homescreen2State();
// }

// class _Homescreen2State extends State<Homescreen2> {
//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> selectedActivity = widget.jsonData;

//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.only(left: 20, right: 25, top: 65),
//               child: Stack(
//                 children: [
//                   const Text(
//                     "Hello,",
//                     style: TextStyle(fontSize: 15, color: Color(0xff6B769B)),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: 5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           StorageManager().name,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             color: Color(0xff161D35),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(bottom: 20),
//                           child: IconButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) {
//                                   return const NotificationScreen();
//                                 }),
//                               );
//                             },
//                             icon: const Icon(
//                               Icons.notifications_none,
//                               size: 32,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: screenWidth,
//               decoration: BoxDecoration(
//                 color: Color(0xfff6f8ff),
//                 borderRadius: BorderRadius.circular(screenWidth * 0.1),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: screenWidth * 0.09,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           width: screenWidth * 0.04,
//                           child: Divider(
//                             color: Colors.grey,
//                           ),
//                         ),
//                         SizedBox(
//                           width: screenWidth * 0.09,
//                           child: Divider(
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     selectedActivity['title'],
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
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
//                       CircleAvatar(
//                         backgroundColor: Color(0xff4995eb),
//                         radius: 30,
//                         child: Icon(
//                           Icons.check,
//                           color: Colors.white,
//                           size: 50,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 80),
//                         child: Column(
//                           children: [
//                             Text(
//                               "Booking",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Text(
//                               selectedActivity['desc'],
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Text(
//                               "You added a sum",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xff6B769B),
//                               ),
//                             ),
//                             Text(
//                               "€${selectedActivity['amount']}",
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xff161D35),
//                               ),
//                             ),
//                             Text(
//                               formatDateString(selectedActivity['created_at']),
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
//                   SizedBox(
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
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           "Summary",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             color: Color(0xff000000),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           width: 300,
//                           child: Divider(
//                             thickness: 0.6,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 20, left: 20),
//                           child: Row(
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
//                                 "€ ${selectedActivity['amount']}",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xff000000),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Container(
//                           width: 300,
//                           child: Divider(
//                             thickness: 0.6,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 20, left: 20),
//                           child: Row(
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
//                                 "€ ${selectedActivity['amount']}",
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
//                   SizedBox(height: screenHeight * 0.1),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String formatDateString(String dateString) {
//     DateTime dateTime = DateTime.parse(dateString);
//     return DateFormat('dd MMMM yyyy').format(dateTime);
//   }
// }

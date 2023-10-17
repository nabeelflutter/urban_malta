// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class MoneySend extends StatefulWidget {
//   const MoneySend({super.key});

//   @override
//   State<MoneySend> createState() => _MoneySendState();
// }

// class _MoneySendState extends State<MoneySend> {
//   bool isFinished = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 65, left: 20, right: 20),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.arrow_back_ios,
//                             size: 24, color: Color(0xff161D35))),
//                     const Text(
//                       "Back To  Wallet",
//                       style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xff161D35)),
//                     )
//                   ],
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   child: Lottie.asset("animation/1.json",
//                       // height: 300,
//                       fit: BoxFit.cover,
//                       reverse: true,
//                       repeat: true),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   "Money sent",
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xff161D35)),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   "Estimated Arrival within 24 hours",
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xff161D35)),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xfff4f8ff),
//                           offset: Offset(-4, -4), // Top shadow
//                           blurRadius: 4, // Spread radius
//                         ),
//                         BoxShadow(
//                           color: Color(0xfff4f8ff),
//                           offset: Offset(0, 4), // Bottom shadow
//                           blurRadius: 4, // Spread radius
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(15)),
//                   height: 70,
//                   width: 300,
//                   child: Container(
//                     padding: EdgeInsets.only(left: 10),
//                     child: ListTile(
//                       leading: Container(
//                         child: Container(
//                           height: 50,
//                           width: 50,
//                           decoration: BoxDecoration(
//                               color: Color(0xffFEEEEE),
//                               borderRadius: BorderRadius.circular(50)),
//                           child: Image.asset("assets/images/j13.png"),
//                         ),
//                       ),
//                       title: Container(
//                         padding: EdgeInsets.only(left: 10, bottom: 5),
//                         child: const Text(
//                           'Your Bank',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff161D35)),
//                         ),
//                       ),
//                       subtitle: Container(
//                         padding: EdgeInsets.only(left: 10),
//                         child: const Text(
//                           '1123222',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff6B769B)),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 const Divider(
//                   thickness: 1,
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 const Text(
//                   "Transfer amount",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xff161D35)),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   "€53.9",
//                   style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xff161D35)),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   "Jun 16, 2020 - 12:56 PM",
//                   style: TextStyle(
//                       // fontSize: 32,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xff6B769B)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//////////////////////////////////
///
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kappu/main.dart';
import 'package:kappu/screens/account/Review.dart';
import 'package:kappu/screens/account/withdrow.dart';
import 'package:kappu/screens/home_page/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/ProviderScreens/dashboard/provider_home.dart';

import '../../components/AppColors.dart';

class MoneySend extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String iban;
  final String amount;
  final bool success;
  const MoneySend(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.iban,
      required this.amount,
      required this.success})
      : super(key: key);

  @override
  State<MoneySend> createState() => _MoneySendState();
}

class _MoneySendState extends State<MoneySend> {
  bool isFinished = false;
  navigateToHome(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            InitialScreen(), // Replace with the widget you want to navigate to
      ),
      (route) =>
          false, // Use a predicate that always returns false to remove all previous routes
    );
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => StorageManager().isProvider
    //             ? const InitialScreen()
    //             : const InitialScreen()));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => navigateToHome(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Container(
            // padding: EdgeInsets.only(top: 20),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 24,
                color: AppColors.iconColor,
              ),
            ),
          ),
          title: Container(
            // padding: EdgeInsets.only(top: 20),
            child: const Text(
              "Back To Wallet",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Row(
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) {
                //           return ReviewTransfer();
                //         }));
                //       },
                //       icon: const Icon(
                //         Icons.arrow_back_ios,
                //         size: 24,
                //         color: Color(0xff161D35),
                //       ),
                //     ),
                //     const Text(
                //       "Back To Wallet",
                //       style: TextStyle(
                //         fontSize: 24,
                //         fontWeight: FontWeight.w700,
                //         color: Color(0xff161D35),
                //       ),
                //     ),
                //   ],
                // ),

                widget.success == true
                    ? Container(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          "animation/1.json",
                          fit: BoxFit.cover,
                          reverse: true,
                          repeat: true,
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        width:
                            200, // Set the width of the container (adjust as needed)
                        height: 200,
                        child: ConstrainedBox(
                          constraints: BoxConstraints
                              .expand(), // Make the animation fill the container
                          child: Lottie.asset(
                            "animation/cancel_payment.json",
                            fit: BoxFit
                                .contain, // Adjust this based on your requirement
                            reverse: true,
                            repeat: true,
                          ),
                        ),
                      ),

                const SizedBox(height: 10),
                Text(
                  widget.success == true ? "Money sent" : "Money Failed",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff161D35),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.success == true
                      ? "Estimated Arrival within 24 hours"
                      : "Some Error is Occured or You haven't enough amount to withdrawal",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff161D35),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xfff4f8ff),
                        offset: const Offset(-4, -4), // Top shadow
                        blurRadius: 4, // Spread radius
                      ),
                      BoxShadow(
                        color: const Color(0xfff4f8ff),
                        offset: const Offset(0, 4), // Bottom shadow
                        blurRadius: 4, // Spread radius
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 70,
                  width: screenWidth * 0.8, // Adjusted width to be responsive
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xffFEEEEE),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.asset("assets/images/j12.png"),
                    ),
                    title: Container(
                      padding: const EdgeInsets.only(left: 10, bottom: 5),
                      child: Text(
                        widget.firstName + " " + widget.lastName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff161D35),
                        ),
                      ),
                    ),
                    subtitle: Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.iban,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6B769B),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Divider(thickness: 1),
                const SizedBox(height: 30),
                const Text(
                  "Transfer amount",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff161D35),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "€${widget.amount}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff161D35),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  " ${DateFormat("dd MMMM, yyyy HH:mm").format(DateTime.now())}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff6B769B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

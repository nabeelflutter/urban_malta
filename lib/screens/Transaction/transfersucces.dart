import 'package:flutter/material.dart';
import 'package:kappu/screens/Transaction/topup.dart';
import 'package:lottie/lottie.dart';
// import 'package:swipeable_button_view/swipeable_button_view.dart';

class TransferSuccess extends StatefulWidget {
  const TransferSuccess({Key? key});

  @override
  State<TransferSuccess> createState() => _TransferSuccessState();
}

class _TransferSuccessState extends State<TransferSuccess> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: screenHeight * 0.1, left: 20, right: 20),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: Color(0xff161D35),
                    ),
                  ),
                  const Text(
                    "Back To Wallet",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff161D35),
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.3,
                child: Lottie.asset(
                  "animation/1.json",
                  fit: BoxFit.cover,
                  reverse: true,
                  repeat: true,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TopUp();
                  }));
                },
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Top Up Success",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff161D35),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your balance now",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff161D35),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "€ 199",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff161D35),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Jun 16, 2020 - 12:56 PM",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6B769B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

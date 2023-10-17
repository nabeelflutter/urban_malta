import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kappu/common/bottom_nav_bar.dart';
import 'package:lottie/lottie.dart';

import '../../components/AppColors.dart';
import 'Create_first_gig.dart';

class GigAnimation extends StatefulWidget {
  bool isSuccess;
  GigAnimation({Key? key, required this.isSuccess}) : super(key: key);

  @override
  State<GigAnimation> createState() => _GigAnimationState();
}

class _GigAnimationState extends State<GigAnimation> {
  //  void _onDataCollected(List<String> data) {
  //   widget.inputData.skills = data;

  //   // You can perform other operations with the data if needed
  //   // ...

  //   // Move to the next page
  //   widget.pageController.nextPage(
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }
  Future<bool> _onWillPop() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavBar(isprovider: true),
      ),
      (route) => false,
    );
    return false; // Prevent default back button behavior
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // centerTitle: true,
          // leading: const BackButton(
          //   color: AppColors.iconColor,
          // ),
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const BottomNavBar(isprovider: true)),
                    (route) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          shadowColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Congrats!\nYour Gig is Live.\nExpect customers to\nsee it soon!',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Container(
                alignment: Alignment.center,
                child: Lottie.asset(
                  "animation/success_animation.json",
                  fit: BoxFit.cover,
                  reverse: true,
                  repeat: true,
                ),
              ),
              Spacer(),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      //Need to Naviagte Home page

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavBar(isprovider: true)),
                        (route) => false,
                      );
                    },
                    child: Text('Go to Dashboard')),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
                // height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kappu/screens/register/social_signup.dart';

import '../register/provider_signup_first.dart';

class Loginpageview2 extends StatefulWidget {
  final PageController pageControllered;
  const Loginpageview2({Key? key, required this.pageControllered})
      : super(key: key);

  @override
  State<Loginpageview2> createState() => _Loginpageview2State();
}

class _Loginpageview2State extends State<Loginpageview2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: const Text(
      //     'urbanmalta',
      //     style: TextStyle(
      //         fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black),
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'urbanmalta',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.pageControllered.jumpToPage(3);
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                // alignment: Alignment.center,
                child: const Text(
                  'showcase your craft; turn every task \n  into a loyal customer relationship',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                // color: Colors.amber,
                child: Image.asset('assets/images/login_pageview2.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

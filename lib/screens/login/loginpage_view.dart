import 'package:flutter/material.dart';
import 'package:kappu/screens/register/social_signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../register/provider_signup_first.dart';
import 'login_p_view_1.dart';
import 'login_p_view_2.dart';
import 'login_p_view_3.dart';
import 'package:flutter/services.dart';

class LoginpageView extends StatefulWidget {
  const LoginpageView({Key? key}) : super(key: key);

  @override
  State<LoginpageView> createState() => _LoginpageViewState();
}

class _LoginpageViewState extends State<LoginpageView> {
  PageController pageControllered = PageController();
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set your desired status bar color
      statusBarIconBrightness: Brightness.dark, // Set icon color to dark
    ));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageControllered,
                onPageChanged: (index) {
                  print(index);
                  setState(() {
                    currentPageIndex = index;
                  });
                  print(currentPageIndex);
                },
                children: [
                  LoginView1(
                    pageControllered: pageControllered,
                  ),
                  Loginpageview2(
                    pageControllered: pageControllered,
                  ),
                  LoginPage3(),
                  SocailSignUpScreen(isprovider: true)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageControllered,
                    count: 4,
                    effect: const SwapEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      int nextPage = pageControllered.page!.toInt() + 1;

                      if (nextPage < 4) {
                        pageControllered.animateToPage(
                          nextPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          currentPageIndex < 3 ? 'Got it' : "",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (currentPageIndex < 3)
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.blue,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

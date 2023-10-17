import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/bottom_nav_bar.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/login/google_signin.dart';
import 'package:kappu/screens/privacy_policy/privacy.dart';
import 'dart:io';
import 'package:the_apple_sign_in/the_apple_sign_in.dart' hide ButtonStyle;
import 'package:kappu/screens/login/widgets/google_login_button.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'register.dart';

class SocailSignUpScreen extends StatelessWidget {
  final bool isprovider;
  const SocailSignUpScreen({
    Key? key,
    required this.isprovider,
  });

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final authService = AppleAuthService();
      final user = await authService
          .signInWithApple(scopes: [Scope.email, Scope.fullName]);
      print('uid: ${user.uid}');
      socialLogin('apple', user.uid, user.email ?? user.uid + "@urbanmalta.com",
          user.displayName ?? "Guest User", context);
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100.h,
                    child: Image.asset('assets/images/login_pageview1.png'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  const Text(
                    'Join urbanmalta',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  // Center(
                  //   child: Image.asset(
                  //     "assets/icons/logo.png",
                  //     height: 80.h,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  // Text(
                  //   "URBAN MALTA",
                  //   style: TextStyle(
                  //     color: Color(0xFF4995EB),
                  //     fontSize: 18,
                  //     fontFamily: 'Montserrat-Bold',
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Create an account and discover thousands of relevant services, connet with freelancers, and check out easily on Urban Malta trusted platform.",
                      style: TextStyle(
                        fontSize: 16,
                        // fontFamily: 'Montserrat-Regular',
                        color: AppColors.text_desc,
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  // const SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Visibility(
                      visible: Platform.isIOS, child: SizedBox(height: 10)),
                  Visibility(
                    visible: Platform.isIOS,
                    child: SizedBox(
                      height: ScreenUtil().screenHeight * 0.05,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().screenHeight * 0.025),
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Opacity(
                              opacity: 0,
                              child: Icon(Icons.apple),
                            ),
                            Text(
                              "Sign In With Apple",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 14.sp,
                                // fontFamily: 'Montserrat-Light',
                              ),
                            ),
                            Image.asset('assets/icons/app.png', scale: 1.0),
                          ],
                        ),
                        onPressed: () async {
                          signInWithApple(context);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FacebookLoginButton(
                    text: 'Connect with Facebook',
                    onTap: (user) {
                      socialLogin('facebook', user["id"], user["email"],
                          user["name"], context);
                    },
                  ),
                  const SizedBox(height: 10),
                  GoogleLoginButton(
                    action: false,
                    text: 'Connect with Google',
                    onTap: (user) {
                      socialLogin('google', user.id!, user.email!,
                          user.displayName!, context);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: ScreenUtil().screenHeight * 0.05,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().screenHeight * 0.025)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Opacity(
                            opacity: 0,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                          Text(
                            "Sign in with Email",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 14.sp,
                              // fontFamily: 'Montserrat-Medium',
                            ),
                          ),
                          Image.asset('assets/icons/arw.png', scale: 1.0),
                        ],
                      ),
                      onPressed: () {
                        print('aaaa');
                        changeScreen(
                            context: context,
                            screen: SignUp(
                              isprovider: this.isprovider,
                            ));
                      },
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'By signing up you accept our ',
                        style: TextStyle(
                            color: const Color(0xFF7b7d83),
                            fontSize: 14,
                            // fontFamily: 'Montserrat-Medium'
                            ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // String url = "https://urbanmalta.com/privacy-policy";
                          // var urllaunchable = await canLaunchUrlString(
                          //     url); //canLaunch is from url_launcher package
                          // if (urllaunchable) {
                          //   await launchUrlString(
                          //       url); //launch is ffrom url_launcher package to launch URL
                          // } else {
                          //   print("URL can't be launched.");
                          // }

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Privacy();
                          }));
                        },
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              // fontFamily: "Montserrat-Medium",
                              fontSize: 14,
                              color: Color(0xFF4995EB)),
                        ),
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.pushReplacement(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     const BottomNavBar(isprovider: false)));
                  //       },
                  //       child: Text(
                  //         "Skip",
                  //         style: TextStyle(
                  //           color: Color(0xFF4995EB),
                  //           fontSize: 14,
                  //           fontFamily: 'Montserrat-Bold',
                  //         ),
                  //       ),
                  //     ),
                  //     Text(
                  //       "",
                  //       style: TextStyle(
                  //         color: Color(0xFF4995EB),
                  //         fontSize: 14,
                  //         fontFamily: 'Montserrat-Bold',
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> socialLogin(String type, String id, String _email,
      String displayName, BuildContext context) async {
    // isLoading = true;
    // setState(() {});
    Map<String, dynamic> body = {
      'login_src': type,
      'social_login_id': id,
      'email': _email,
      'fcm_token': StorageManager().fcmToken,
      'os': Platform.isAndroid ? 'android' : 'ios',
    };
    await HttpClient().signinSocial(body).then((loginresponse) async {
      if (loginresponse.data['isSuccess'] == true) {
        StorageManager().accessToken = "" + loginresponse.data['data']['token'];
        StorageManager().userId = loginresponse.data['data']['user']['id'];
        StorageManager().name =
            "" + loginresponse.data['data']['user']['first_name'];
        StorageManager().isSocialUser = true;

        StorageManager().email =
            "" + loginresponse.data['data']['user']['email'];
        StorageManager().isProvider =
            loginresponse.data['data']['user']['is_provider'] ? true : false;
        StorageManager().nationality =
            "" + loginresponse.data['data']['user']['nationality'];

        if (loginresponse.data['data']['user']['customer_stripe_id'] != null)
          StorageManager().stripeId =
              "" + loginresponse?.data['data']['user']['customer_stripe_id'];
        StorageManager().language =
            "" + loginresponse.data['data']['user']['languages'];
        // StorageManager().phone = ""+loginresponse.data['data']['user']['phone_number'];

        changeScreenReplacement(
            context,
            BottomNavBar(
              isprovider: loginresponse.data['data']['user']['is_provider'],
            ));
      } else {
        changeScreen(
            context: context,
            screen: SignUp(
              isprovider: this.isprovider,
              loginType: type,
              name: displayName,
              socialId: id,
              email: _email,
            ));
      }

      // Navigator.pop(context);
    }).catchError((error) {
      changeScreen(
          context: context,
          screen: SignUp(
            isprovider: true,
            loginType: type,
            name: displayName,
            socialId: id,
            email: _email,
          ));
    });
  }
}

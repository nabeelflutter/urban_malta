// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kappu/common/bottom_nav_bar.dart';
// import 'package:kappu/helperfunctions/screen_nav.dart';
// import 'package:kappu/screens/login/login_screen.dart';
// import 'package:kappu/screens/register/provider_or_user.dart';

// import '../../common/button.dart';
// import '../../common/painter.dart';

// class LoginOrRegistration extends StatelessWidget {
//   const LoginOrRegistration({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomPaint(
//         painter: SignUpPainter(),
//         child: Column(
//           children: [
//             270.verticalSpace,
//             20.verticalSpace,
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 60.w),
//               child: CustomButton(
//                 buttontext: 'Login',
//                 isLoading: false,
//                 onPressed: () {
//                   changeScreen(context: context, screen: const LoginScreen());
//                 },
//               ),
//             ),
//             10.verticalSpace,
//             TextButton(
//               onPressed: () {
//                 changeScreen(context: context, screen: const ProviderOrUser());
//               },
//               child: Text(
//                 'Create an account',
//                 style: TextStyle(
//                     fontSize: ScreenUtil().setSp(12),
//                     fontFamily: 'Montserrat-Normal',
//                     color: Colors.blue),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12.w),
//               child: Row(children: <Widget>[
//                 const Expanded(
//                     child: Divider(
//                   color: Colors.black,
//                 )),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8.0.w),
//                   child: Text(
//                     "or",
//                     style: TextStyle(
//                         fontSize: ScreenUtil().setSp(12),
//                         fontFamily: 'Montserrat-Normal',
//                         color: Colors.blue),
//                   ),
//                 ),
//                 const Expanded(
//                     child: Divider(
//                   color: Colors.black,
//                 )),
//               ]),
//             ),
//             TextButton(
//               onPressed: () {
//                 changeScreen(
//                     context: context,
//                     screen: const BottomNavBar(isprovider: false));
//               },
//               child: Text(
//                 'Continue as a guest',
//                 style: TextStyle(
//                     fontSize: ScreenUtil().setSp(12),
//                     fontFamily: 'Montserrat-Normal',
//                     color: Colors.blue),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:kappu/components/AppColors.dart';

import '../../helperfunctions/screen_nav.dart';
import '../login/login_screen.dart';
import '../login/widgets/google_login_button.dart';
import '../register/provider_or_user.dart';

class LoginOrRegistration extends StatelessWidget {
  const LoginOrRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.app_color,
                    )),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      const Spacer(
                        flex: 2,
                      ),
                      const Text(
                        "Existing members",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            // fontFamily: 'Montserrat-Bold',
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),

                            padding: const EdgeInsets.all(16.0),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: AppColors.app_color,
                              // fontFamily: 'Montserrat-Bold',
                            ),
                          ),
                          onPressed: () {
                            changeScreen(
                                context: context, screen: LoginScreen());
                          },
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  const SizedBox(height: 10.0),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            // fontFamily: 'Montserrat-Bold',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.app_color, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          padding: const EdgeInsets.all(16.0),
                        ),
                        onPressed: () {
                          changeScreen(
                              context: context, screen: ProviderOrUser());
                        },
                      )),
                  const SizedBox(height: 20.0),
                  // const Or("or continue with"),
                  GoogleLoginButton(
                      action: false, text: 'Sign in With Google',onTap: (user){

                  },),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     ElevatedButton.icon(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(2.0)),
                  //       color: Colors.red,
                  //       icon: Icon(
                  //         FontAwesomeIcons.google,
                  //         color: Colors.white,
                  //       ),
                  //       label: const Text(
                  //         "Google",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       onPressed: () {},
                  //     ),
                  //     const SizedBox(width: 10.0),
                  //     ElevatedButton.icon(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(2.0)),
                  //       color: Colors.indigo,
                  //       icon: Icon(
                  //         FontAwesomeIcons.facebook,
                  //         color: Colors.white,
                  //       ),
                  //       label: const Text(
                  //         "Facebook",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       onPressed: () {},
                  //     ),
                  //   ],
                  // ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

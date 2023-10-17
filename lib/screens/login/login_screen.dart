import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/custom_progress_bar.dart';
import 'package:kappu/common/customtexts.dart';
import 'package:kappu/common/dialogues.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/screens/login/widgets/google_login_button.dart';
import 'package:kappu/screens/register/register.dart';
import 'package:kappu/screens/register/social_signup.dart';
import 'package:kappu/screens/register/widgets/text_field2.dart';
import 'package:kappu/screens/reset_password/enter_email_screen.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart' hide ButtonStyle;
import 'package:validators/validators.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:kappu/screens/register/widgets/text_field.dart';

import '../../common/bottom_nav_bar.dart';
import '../../constants/icons.dart';
import '../../net/base_dio.dart';
import '../../net/http_client.dart';
import '../register/provider_or_user.dart';
import '../register/provider_signup_first.dart';
import '../register/widgets/text_field.dart';
import 'google_signin.dart';

class LoginScreen extends StatefulWidget {
  bool isFromOtherScreen;

  LoginScreen({this.isFromOtherScreen = false});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool _showPassword = true;
  bool signin = false;
  bool isLoading = false;
  final _formState = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVaildEmail = true;
  bool isValidPassword = true;

  @override
  initState() {}

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final authService = AppleAuthService();
      final user = await authService
          .signInWithApple(scopes: [Scope.email, Scope.fullName]);
      print('uid: ${user.uid}');
      socialLogin('apple', user.uid, user.email ?? user.uid + "@urbanmalta.com",
          user.displayName ?? "Guest User");
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var children2 = [
      120.verticalSpace,
      returnLogo(context),
      15.verticalSpace,
      customtext(
          buttontext: 'Welcome to Urban Malta',
          fontSize: 20,
          fontfailmy: "Montserrat-Bold"),
      15.verticalSpace,
      CustomTextFormField2(
        controller: emailController,
        validator: (value) => isEmail(value!) ? null : "Check your email",
        keyboardType: TextInputType.emailAddress,
        prefixIcon: ImageIcon(
          AssetImage('assets/icons/ft-4.png'),
          color: AppColors.app_color,
        ),
        suffixIcon: isEmail(email) ? checkIcon : null,
        hintText: ' Enter Email',
        isValid: isVaildEmail,
        onChanged: (value) {
          if (value.isNotEmpty && isEmail(value)) {
            isVaildEmail = true;
          } else {
            isVaildEmail = false;
          }
          setState(() {});
        },
      ),

      // ElevatedTextFormField(
      //   controller: emailController,
      //   isValid: isVaildEmail,
      //   keyboardType: TextInputType.emailAddress,
      //   prefixIcon: emailIcon,
      //   suffixIcon: isEmail(email) ? checkIcon : null,
      //   showPassword: false,
      //   hintText: 'Enter Email',
      //   onChanged: (value) {
      //     if (isEmail(value)) {
      //       isVaildEmail = true;
      //     } else {
      //       isVaildEmail = false;
      //     }
      //     email = value;
      //     setState(() {});
      //   },
      // ),
      15.verticalSpace,
      CustomTextFormField(
        showPassword: _showPassword,
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        isValid: isValidPassword,
        onChanged: (value) {
          if (value.isNotEmpty) {
            isValidPassword = true;
          } else {
            isValidPassword = false;
          }
          setState(() {});
        },
        validator: (value) {
          if (value.isNullOrEmpty) {
            return "Enter Your password";
          }
        },
        prefixIcon: passwordIcon,
        suffixIcon: GestureDetector(
            onTap: () {
              _showPassword = !_showPassword;
              setState(() {});
            },
            child: _showPassword ? passwordEyeIcon : passwordGreenEyeIcon),
        hintText: "Enter Password",
      ),

      // Material(
      //     borderRadius: BorderRadius.circular(25),
      //     elevation: 3,
      //     shadowColor: Colors.black.withOpacity(0.14),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         TextFormField(
      //           controller: passwordController,
      //           textAlignVertical: TextAlignVertical.center,
      //           onChanged: (value) {
      //             if (value.isNotEmpty) {
      //               isValidPassword = true;
      //             } else {
      //               isValidPassword = false;
      //             }
      //             setState(() {});
      //           },
      //           decoration: InputDecoration(
      //             prefixIcon: Padding(
      //               padding:
      //                   const EdgeInsetsDirectional.only(start: 20, end: 15),
      //               child: passwordIcon,
      //             ),
      //             // prefixIconConstraints:
      //             //     BoxConstraints(maxHeight: ScreenUtil().setWidth(20)),
      //             suffixIcon: Padding(
      //               padding: const EdgeInsets.only(right: 12.0),
      //               child: GestureDetector(
      //                   onTap: () {
      //                     _showPassword = !_showPassword;
      //                     setState(() {});
      //                   },
      //                   child: _showPassword
      //                       ? passwordEyeIcon
      //                       : passwordGreenEyeIcon),
      //             ),
      //             suffixIconConstraints: const BoxConstraints(maxHeight: 25),
      //             suffixIconColor: Colors.green,
      //             hintText: 'Enter Password',
      //             hintStyle: const TextStyle(
      //               fontWeight: FontWeight.w500,
      //             ),
      //             border: InputBorder.none,
      //           ),
      //           obscureText: _showPassword,
      //           obscuringCharacter: '*',
      //         ),
      //         if (!isValidPassword)
      //           const Text(
      //             'Please enter your password',
      //             style: TextStyle(color: AppColors.red),
      //           )
      //       ],
      //     )),
      10.verticalSpace,
      Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            changeScreen(context: context, screen: const EnterEmailScreen());
          },
          child: customtext(
            buttontext: 'Forgot Your Password?',
            fontfailmy: "Montserrat-Medium",
            color: AppColors.app_color,
            fontSize: 10,
          ),
        ),
      ),
      15.verticalSpace,
      SizedBox(
        height: ScreenUtil().screenHeight * 0.05,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.app_color),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ScreenUtil().screenHeight * 0.025),
              ),
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
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  // fontFamily: 'Montserrat-Medium',
                ),
              ),
              Image.asset('assets/icons/arw.png', scale: 1.0),
            ],
          ),
          onPressed: () async {
            if (passwordController.text.isEmpty ||
                emailController.text.isEmpty ||
                !isEmail(emailController.text)) {
              return;
            }
            if (!signin) {
              signin = true;
              isLoading = true;
              setState(() {});
              Map<String, dynamic> body = {
                //added .trim and .toLowerCase
                'email': emailController.text.trim().toLowerCase(),
                'password': passwordController.text,
                'fcm_token': StorageManager().fcmToken,
                'os': Platform.isAndroid ? 'android' : 'ios',
              };
              await HttpClient().signin(body).then((loginresponse) async {
                if (loginresponse.data['isSuccess'] == true) {
                  StorageManager().accessToken =
                      "" + loginresponse.data['data']['token'];
                  StorageManager().userId =
                      loginresponse.data['data']['user']['id'];
                  StorageManager().name =
                      "" + loginresponse.data['data']['user']['first_name'];
                  StorageManager().email =
                      "" + loginresponse.data['data']['user']['email'];
                  StorageManager().isProvider = loginresponse.data['data']
                          ['user']['is_provider']
                      ? true
                      : false;
                  StorageManager().nationality =
                      "" + loginresponse.data['data']['user']['nationality'];
                  StorageManager().language =
                      "" + loginresponse.data['data']['user']['languages'];
                  if (loginresponse.data['data']['user']
                          ['customer_stripe_id'] !=
                      null)
                    StorageManager().stripeId = "" +
                        loginresponse.data['data']['user']
                            ['customer_stripe_id'];
                  StorageManager().userImage = loginresponse.data['data']
                              ['user']['profile_pic'] !=
                          null
                      ? "" + loginresponse.data['data']['user']['profile_pic']
                      : "";
                  // StorageManager().phone = ""+loginresponse.data['data']['user']['phone_number'];
                }
                signin = false;
                isLoading = false;
                print('aaaaa');
                (widget.isFromOtherScreen &&
                        loginresponse.data['data']['user']['is_provider'] ==
                            false)
                    ? Navigator.pop(context, "1")
                    : Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                        return BottomNavBar(
                          isprovider: loginresponse.data['data']['user']
                              ['is_provider'],
                        );
                      }), (r) {
                        return false;
                      });

                // widget.isFromOtherScreen
                //     ? Navigator.pop(context, "1")
                //     : changeScreenReplacement(
                //         context,
                //         BottomNavBar(
                //           isprovider: loginresponse.data['data']['user']['is_provider'],
                //         ));
                // Navigator.pop(context);
              }).catchError((error) {
                BaseDio.getDioError(error);
                signin = false;
                isLoading = false;
                setState(() {});
                showAlertDialog(
                    error: "Please check the credentials", errorType: "Alert");
              });
            }
          },
        ),
      ),
      Visibility(visible: Platform.isIOS, child: 10.verticalSpace),
      Visibility(
        visible: Platform.isIOS,
        child: SizedBox(
          height: ScreenUtil().screenHeight * 0.05,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().screenHeight * 0.025),
                  side: const BorderSide(width: 1, color: Colors.black),
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
      10.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: FacebookLoginButton(
            text: 'Facebook',
            onTap: (user) {
              if (user.containsKey("email")) {
                socialLogin(
                    'facebook', user["id"], user["email"], user["name"]);
              } else {
                socialLogin('facebook', user["id"],
                    user["id"] + "@urbanmalta.com", user["name"]);
              }
            },
          )),
          15.horizontalSpace,
          Expanded(
              child: GoogleLoginButton(
            action: false,
            text: 'Google',
            onTap: (user) {
              socialLogin(
                  'google', user.id, user.email, user.displayName ?? "");
            },
          )),
        ],
      ),

      20.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account? ',
            style: TextStyle(
                color: const Color(0xFF767F94),
                fontSize: ScreenUtil().setWidth(13)),
          ),
          GestureDetector(
            onTap: () {
              // before this screen open

              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return SocailSignUpScreen(
              //     isprovider: true,
              //   );
              // }));

              // now this screen open
              changeScreen(
                  context: context,
                  screen: SignUp(
                    isprovider: false,
                  ));
            },
            child: const Text(
              'Signup',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.app_color),
            ),
          )
        ],
      ),
    ];
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                  key: _formState,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: children2,
                    ),
                  )),
              if (isLoading) const CustomProgressBar()
            ],
          ),
        ),
      ),
    );
  }

  Image returnLogo(BuildContext context) {
    return Image.asset(
      'assets/images/colorfulLogo.png',
      scale: 1.5,
      fit: BoxFit.fill,
    );
  }

  Future<void> socialLogin(
      String type, String id, String email, String displayName) async {
    print(widget.isFromOtherScreen);
    isLoading = true;
    setState(() {});
    Map<String, dynamic> body = {
      'login_src': type,
      'social_login_id': id,
      'email': email,
      'fcm_token': StorageManager().fcmToken,
      'os': Platform.isAndroid ? 'android' : 'ios',
    };
    await HttpClient().signinSocial(body).then((loginresponse) async {
      if (loginresponse.data['isSuccess'] == true) {
        StorageManager().accessToken = "" + loginresponse.data['data']['token'];
        StorageManager().userId = loginresponse.data['data']['user']['id'];
        StorageManager().isSocialUser = true;
        StorageManager().name =
            "" + loginresponse.data['data']['user']['first_name'];
        StorageManager().email =
            "" + loginresponse.data['data']['user']['email'];
        if (loginresponse.data['data']['user']['customer_stripe_id'] != null)
          StorageManager().stripeId =
              "" + loginresponse.data['data']['user']['customer_stripe_id'];
        StorageManager().isSocialUser = true;
        StorageManager().isProvider =
            loginresponse.data['data']['user']['is_provider'] ? true : false;
        StorageManager().nationality =
            "" + loginresponse.data['data']['user']['nationality'];
        StorageManager().language =
            "" + loginresponse.data['data']['user']['languages'];
        // StorageManager().phone = ""+loginresponse.data['data']['user']['phone_number'];
        signin = false;
        isLoading = false;
        print('aaaaa');
        (widget.isFromOtherScreen &&
                loginresponse.data['data']['user']['is_provider'] == false)
            ? Navigator.pop(context, "1")
            : changeScreenReplacement(
                context,
                BottomNavBar(
                  isprovider: loginresponse.data['data']['user']['is_provider'],
                ));
        // Navigator.pop(context);
      } else {
        isLoading = false;
        registerUser(type, displayName, id, email);
      }
    }).catchError((error) {
      print("abdullah bhai error hai $error");
      signin = false;
      isLoading = false;
      setState(() {});
      registerUser(type, displayName, id, email);
    });
  }

  registerUser(loginType, name, String socialId, email) async {
    print('aacccdddddd');
    if (!isLoading) {
      setState(() {
        this.isLoading = true;
      });
      Map<String, dynamic> body = {
        'first_name': name,
        'username': "",
        'last_name': "",
        'email': email,
        'phone_number': "",
        'password': '',
        'login_src': loginType,
        'social_login_id': socialId,
        'fcm_token': StorageManager().fcmToken,
        'os': Platform.isAndroid ? 'android' : 'ios',
        'language': "English",
        'nationality': "Malta"
      };

      await HttpClient().userSignup(body, new File("path")).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value?.data['status']) {
          var provider = StorageManager();
          provider.accessToken = value?.data['token'];
          provider.name = name;
          provider.phone = " ";
          provider.email = email;
          provider.isProvider = false;
          StorageManager().isSocialUser =
              (socialId != null && socialId.length > 0) ? true : false;
          provider.nationality = value?.data['user']['nationality'];
          provider.userId = value?.data['user']['id'];
          provider.language = value?.data['user']['languages'];
          provider.stripeId = "" + value?.data['user']['customer_stripe_id'];

          widget.isFromOtherScreen
              ? Navigator.pop(context, "1")
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const BottomNavBar(isprovider: false)));
        }
      }).catchError((e) {
        setState(() {
          this.isLoading = false;
        });
        BaseDio.getDioError(e);
      });
    }
  }
}

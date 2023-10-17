import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:video_player/video_player.dart';

import '../../common/bottom_nav_bar.dart';
import 'login_screen.dart';
import 'loginpage_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    askForAppTransparency();
    controller = VideoPlayerController.asset('assets/videos/splash_gif.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          controller.play();
          controller.setLooping(true);
        });
      });
  }

  Future<void> askForAppTransparency() async {
    await Permission.appTrackingTransparency.request();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(1000),
      body: CustomPaint(
        child: Stack(
          //alignment:new Alignment(x, y)
          children: <Widget>[
            controller.value.isInitialized
                ? Container(
                    margin: const EdgeInsets.only(bottom: 140),
                    width: double.infinity,
                    // color: Colors.black,
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  )
                : Container(),
            signInView(context),
          ],
        ),
      ),
    );
  }

  Column signInView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(),
        Row(
          children: [
            const SizedBox(width: 20),
            returnLogo(context),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            const SizedBox(width: 25),
            returnMarketPlaceText(),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 20.h,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ElevatedButton(
                onPressed: () {
                  // ShowSkipDialog(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const BottomNavBar(isprovider: false),
                    ),
                  );
                },
                child: returnButtonWithTextImage(
                  context,
                  'assets/images/find_icon.png',
                  "Find a service\n",
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: .7, sigmaY: 1),
            //   child: Container(),
            // ),

            // Flexible(
            //     flex: 1,
            //     fit: FlexFit.tight,
            //     child: ElevatedButton(
            //         onPressed: () {
            //           ShowFindServiceDialog(context);
            //           // Navigator.pushReplacement(
            //           //     context,
            //           //     MaterialPageRoute(
            //           //         builder: (context) =>
            //           //             const BottomNavBar(isprovider: false)));
            //         },
            //         child: returnButtonWithTextImage(context,
            //             'assets/images/find_icon.png', "Find a service\n"),
            //         style: ElevatedButton.styleFrom(
            //             primary: Colors.white, // Background color
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10.0),
            //             )))),
            SizedBox(
              width: 20.h,
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             const ProviderSignupFirstScreen()));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginpageView();
                      }));
                    },
                    child: returnButtonWithTextImage(
                        context,
                        'assets/images/seller_icon.png',
                        "Become a Service\n Provider"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )))),
            SizedBox(
              width: 20.h,
            ),
          ],
        ),
        SizedBox(
          height: 22.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 12.h,
            ),
            Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      changeScreen(context: context, screen: LoginScreen());
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.app_color,
                        primary: AppColors.app_color,
                        side: const BorderSide(
                            color: AppColors.app_color, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          // fontFamily: 'Montserrat-Bold',
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ))),
            SizedBox(
              width: 15.h,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity, // Full width

                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(30.0),
                    //   border: Border.all(color: AppColors.app_color, width: 1),
                    //   color: Colors.transparent,
                    // ),
                    child: OutlinedButton(
                      onPressed: () {
                        // ShowSkipDialog(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavBar(isprovider: false),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        primary: AppColors.app_color,
                        side: BorderSide(color: Colors.white, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          // fontFamily: 'Montserrat-Bold',
                          color: AppColors.app_color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      // child: BackdropFilter(
                      //   filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      //   child:
                      //       Container(), // This container is used only for the blur effect
                      // ),
                    ),
                  ),
                ],
              ),
            ),

            // Expanded(
            //     child: OutlinedButton(
            //         onPressed: () {
            //           // ShowFindServiceDialog(context);
            //           Navigator.pushReplacement(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       const BottomNavBar(isprovider: false)));
            //         },
            //         style: OutlinedButton.styleFrom(
            //             backgroundColor: Colors.transparent,
            //             primary: AppColors.app_color,
            //             side: const BorderSide(
            //                 color: AppColors.app_color, width: 1),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(30.0),
            //             )),
            //         child: const Text(
            //           "Skip",
            //           style: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               fontSize: 14.0,
            //               fontFamily: 'Montserrat-Bold',
            //               color: AppColors.app_color),
            //           textAlign: TextAlign.center,
            //         ))),
            SizedBox(
              width: 12.h,
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }

  SizedBox returnButtonWithTextImage(
      BuildContext context, String imageName, String titleStr) {
    return SizedBox(
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Image.asset(
              imageName,
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              titleStr,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  // fontFamily: 'Montserrat-Bold',
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ));
  }

  Text returnMarketPlaceText() {
    return const Text(
      "One Marketplace\nFor all Local Services.",
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 28.0,
          // fontFamily: 'Montserrat-Bold',
          color: Colors.white),
      textAlign: TextAlign.start,
    );
  }

  Image returnLogo(BuildContext context) {
    return Image.asset(
      'assets/images/colorfulLogo.png',
      width: MediaQuery.of(context).size.width * 0.23,
      height: MediaQuery.of(context).size.height * 0.1,
      fit: BoxFit.fill,
    );
  }
}

void ShowFindServiceDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text(
          'Comming Soon',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

void ShowSkipDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // Use Dialog instead of AlertDialog for more customization
        shape: RoundedRectangleBorder(
          // Apply a rounded border
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Comming Soon!',
                    style: TextStyle(
                        // fontFamily: 'Raleway-bold',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Starting 15th September, Users can sign in here. Service Providers in the mean time, please proceed to create your account',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'Raleway-lihgt',
                    ),
                  ),
                ),
                // SizedBox(height: 5),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   child: const Text(
                //     'Thank you for joining UrbanMalta!',
                //     style: TextStyle(fontSize: 14, color: Colors.grey),
                //   ),
                // ),
                Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginpageView()));
                          },
                          child: const Text(
                            'Become a Service Provider',
                            style: TextStyle(),
                          )),
                    )
                  ],
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.1,
                // ),
                // ElevatedButton(
                //     onPressed: () {}, child: Text('Become a Service Provider'))
                // TextButton(
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                //   child: Text('Become a Service Provider'),
                // ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

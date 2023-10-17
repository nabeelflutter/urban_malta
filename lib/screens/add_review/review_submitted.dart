import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/ProviderScreens/dashboard/provider_home.dart';
import 'package:kappu/screens/home_page/home_screen.dart';

class ReviewSubmitted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(590),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/ratingSubmitThanks.png', // Replace with your image path
                            width: MediaQuery.of(context).size.width *
                                0.8, // Set the width of the image
                            height: 200, // Set the height of the image
                            fit: BoxFit
                                .contain, // Set the fit of the image inside the container
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Thanks for Sharing!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(22, 29, 53, 1),
                              // fontFamily: 'Merriweather',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Your review has been submitted successfully. Your ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(22, 29, 53, 1),
                              // fontFamily: 'Cabin',
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'feedback is instrumental in helping us and the service ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(22, 29, 53, 1),
                              // fontFamily: 'Cabin',
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'provider to improve. Keep sharing, keep helping!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(22, 29, 53, 1),
                              // fontFamily: 'Cabin',
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.3),
                          Container(
                            width: 301.5107116699219,
                            height: 53,
                            child: ElevatedButton(
                              onPressed: () {
                                bool isProvider = StorageManager().isProvider;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => isProvider
                                          ? ProviderHomeScreen()
                                          : HomeScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(73, 149, 235, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadowColor: Color.fromRGBO(241, 246, 255, 1),
                                elevation: 5,
                              ),
                              child: Text(
                                'Explore GiGs',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  // fontFamily: 'Hind Siliguri',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1.0625,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

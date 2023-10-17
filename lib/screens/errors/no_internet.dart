import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetScreen extends StatelessWidget {
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
                            'assets/images/noInternet.png', // Replace with your image path
                            width: MediaQuery.of(context).size.width * 0.7, // Set the width of the image
                            height: 200, // Set the height of the image
                            fit: BoxFit.contain, // Set the fit of the image inside the container
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'OOPS !',
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
                            'You either have a slow or no ',
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
                          SizedBox(height: 2.0),
                          Text(
                            'internet connection at all',
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

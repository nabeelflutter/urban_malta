import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/bottom_nav_bar.dart';
import 'package:kappu/common/button.dart';
import 'package:kappu/common/custom_progress_bar.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'package:kappu/net/http_client.dart';

class ProviderOrUser extends StatefulWidget{

  ProviderOrUser(
      {Key? key,
        this.loginType = '',
        this.socialId = '',
        this.name = '',
        this.isFromOtherScreen = false,
        this.email = ''})
      : super(key: key);
  final String loginType;
  final String socialId;
  final String name;
  final String email;
  bool? isFromOtherScreen = false;


  @override
  State<StatefulWidget> createState() {
    return ProviderOrUserState();
  }
}

class ProviderOrUserState extends State<ProviderOrUser> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children:[
        Container(
        alignment: Alignment.center,
        height: double.infinity,
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/icons/logo.png",
                height: 90.h,
                fit: BoxFit.cover,
              ),
            ),
            30.verticalSpace,
            CustomButton(
              buttontext: 'Register as Provider',
              isLoading: false,
              onPressed: () {
                changeScreen(
                    context: context,
                    screen: SignUp(
                      isprovider: true,
                      loginType: widget.loginType,
                      name: widget.name,
                      socialId: widget.socialId,
                      email: widget.email,
                    ));
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(0.02.sh)),
            CustomButton(
              buttontext: 'Register as User',
              isLoading: false,
              onPressed: () {
                if(widget.socialId.isNullOrEmpty){
                  changeScreen(
                      context: context,
                      screen: SignUp(
                        isprovider: false,
                        loginType: widget.loginType,
                        name: widget.name,
                        socialId: widget.socialId,
                        email: widget.email,
                      ));
                }else {
                  registerUser(widget.loginType, widget.name, widget.socialId,
                    widget.email,);
                }
                },
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
          if (isLoading) const CustomProgressBar()

        ])
    );
  }

  registerUser(loginType, name,socialId, email) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? address= prefs.getString('currentLocation');
    String? lat= prefs.getString('lat');
    String? long= prefs.getString('long');
    print('aacccdddddd');
    if (!isLoading) {
      setState(() {
        this.isLoading = true;
      });
      Map<String, dynamic> body =  {
        'first_name': name,
        'username': "",
        'last_name': "",
        'email': email,
        "location" : address,
        'lat' : lat,
        'lng' : long,
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
          provider.nationality = value?.data['user']['nationality'];
          provider.userId = value?.data['user']['id'];
          provider.language = value?.data['user']['languages'];
          provider.stripeId =
              "" + value?.data['user']['customer_stripe_id'];

        }
        widget.isFromOtherScreen??false
            ? Navigator.pop(context, "1")
            :
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBar(isprovider: false)));
      }).catchError((e) {
        setState(() {
          this.isLoading = false;
        });
        BaseDio.getDioError(e);
      });
    }
  }

}

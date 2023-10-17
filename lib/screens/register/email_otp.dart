import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/button.dart';
import 'package:kappu/common/customtexts.dart';
import 'package:kappu/common/painter.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';

import '../../constants/icons.dart';
import 'confirm_code_screen.dart';

class EmailOTPConfirmation extends StatefulWidget {
  final String email;
  final int id;
  const EmailOTPConfirmation({Key? key, required this.email, required this.id})
      : super(key: key);

  @override
  _EmailOTPConfirmationState createState() => _EmailOTPConfirmationState();
}

class _EmailOTPConfirmationState extends State<EmailOTPConfirmation> {
  late TextEditingController emailController;

  bool sendingcode = false;
  @override
  void initState() {
    emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: SignUpPainter(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace,
              const BackButton(
                color: Colors.blue,
              ),
              30.verticalSpace,
              Center(
                child: Image.asset(
                  "assets/images/envelope.png",
                  height: ScreenUtil().setHeight(200),
                ),
              ),
              50.verticalSpace,
              Center(
                child: customtext(
                  buttontext: "Email Varification",
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              30.verticalSpace,
              customtext(
                  buttontext:
                      "We will email you an OTP to varify that the Email you provided belongs to you",
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
              40.verticalSpace,
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: emailIcon,
                  ),
                  prefixIconConstraints:
                      BoxConstraints(maxHeight: ScreenUtil().setHeight(20)),
                  hintText: widget.email,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              20.verticalSpace,
              CustomButton(
                buttontext: 'Send OTP',
                isLoading: sendingcode,
                onPressed: () async {
                  changeScreen(
                      context: context,
                      screen: Otp(
                        email: emailController.text,
                        id: widget.id,
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

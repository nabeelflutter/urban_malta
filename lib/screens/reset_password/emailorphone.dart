import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/button.dart';
import 'package:kappu/common/painter.dart';
import 'package:kappu/screens/reset_password/varrify_forgetpass_otp.dart';
import '../../common/customtexts.dart';
import '../../models/serializable_model/forget_password_response.dart';
import '../../net/base_dio.dart';
import '../../net/http_client.dart';

class EmailOrphoneOTP extends StatefulWidget {
  final ForgetPasswordResponse forgetPasswordResponse;
  const EmailOrphoneOTP({Key? key, required this.forgetPasswordResponse})
      : super(key: key);

  @override
  _EmailOrphoneOTPState createState() => _EmailOrphoneOTPState();
}

class _EmailOrphoneOTPState extends State<EmailOrphoneOTP> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String email = '';

  bool sendingcodetoemail = false;
  bool sendingcodetophone = false;
  bool disableemailbutton = false;
  bool disablephonebutton = false;
  bool sendingcode = false;
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
              80.verticalSpace,
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/images/cheese-logo-trasparente.png",
                    height: 120.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              80.verticalSpace,
              Center(
                child: customtext(
                  buttontext: "Send OTP",
                  fontfailmy: 'Montserrat-ExtraBold',
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              10.verticalSpace,
              customtext(
                buttontext:
                    "Select the option where you want to Recieve OTP to reset your password",
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              100.verticalSpace,
              CustomButton(
                buttontext: widget.forgetPasswordResponse.email,
                isLoading: sendingcodetoemail,
                onPressed: () async {
                  if (!disableemailbutton) {
                    sendingcodetoemail = true;
                    disableemailbutton = true;
                    disablephonebutton = true;
                    setState(() {});
                    HttpClient()
                        .sendotpemail(
                            widget.forgetPasswordResponse.id.toString())
                        .then(
                      (value) {
                        disablephonebutton = false;
                        disableemailbutton = false;
                        sendingcodetoemail = false;
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VarifyOtp(
                                      isemailoptedforotp: true,
                                      forgetPasswordResponse:
                                          widget.forgetPasswordResponse,
                                    )));
                      },
                    ).catchError((error) {
                      disablephonebutton = false;
                      sendingcodetoemail = false;
                      disableemailbutton = false;
                      setState(() {});
                      BaseDio.getDioError(error);
                    });
                  }
                },
              ),
              20.verticalSpace,
              CustomButton(
                buttontext: widget.forgetPasswordResponse.phonenumber,
                isLoading: sendingcodetophone,
                onPressed: () async {
                  if (!disablephonebutton) {
                    disablephonebutton = true;
                    sendingcodetophone = true;
                    disableemailbutton = true;
                    setState(() {});
                    HttpClient()
                        .sendotpphno(
                            widget.forgetPasswordResponse.id.toString())
                        .then(
                      (value) {
                        disablephonebutton = false;
                        sendingcodetophone = false;
                        sendingcodetophone = false;
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VarifyOtp(
                                    isemailoptedforotp: false,
                                    forgetPasswordResponse:
                                        widget.forgetPasswordResponse)));
                      },
                    ).catchError((error) {
                      disableemailbutton = false;
                      disablephonebutton = false;
                      sendingcodetophone = false;
                      setState(() {});
                      BaseDio.getDioError(error);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

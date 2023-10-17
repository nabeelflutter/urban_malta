import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/button.dart';
import 'package:kappu/common/painter.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:validators/validators.dart';

import '../../common/customtexts.dart';
import '../../constants/icons.dart';
import '../../net/base_dio.dart';
import '../../net/http_client.dart';
import 'emailorphone.dart';
import '../register/widgets/text_field.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({Key? key}) : super(key: key);

  @override
  _EnterEmailScreenState createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  TextEditingController emailController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  String email = '';
  bool varifyingemail = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: SignUpPainter(),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Form(
            key: _formState,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  buttontext: "Email Varification",
                  fontfailmy: 'Montserrat-ExtraBold',
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              30.verticalSpace,
              customtext(
                buttontext:
                    "Enter the Email Associated with your Account and we will send you an email with instruction to reset your password",
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              60.verticalSpace,
              CustomTextFormField(
                controller: emailController,
                validator: (value) =>
                    isEmail(value!) ? null : "Check your email",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: emailIcon,
                suffixIcon: isEmail(email) ? checkIcon : null,
                showPassword: false,
                hintText: 'Email',
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),
              CustomButton(
                isLoading: varifyingemail,
                buttontext: 'Send OTP',
                onPressed: () async {
                  if (_formState.currentState!.validate()) {
                    varifyingemail = true;
                    setState(() {});
                    Map<String, dynamic> body = {
                      'email': emailController.text.trim(),
                    };
                    HttpClient().varifyemail(body).then((value) {
                      varifyingemail = false;
                      changeScreen(
                          context: context,
                          screen: EmailOrphoneOTP(
                            forgetPasswordResponse: value,
                          ));
                    }).catchError((error) {
                      varifyingemail = false;
                      setState(() {});
                      BaseDio.getDioError(error);
                    });
                  }
                },
              ),
            ]),
          )),
    ));
  }
}

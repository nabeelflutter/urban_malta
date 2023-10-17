import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/button.dart';
import 'package:kappu/common/painter.dart';
import 'package:kappu/constants/icons.dart';
import 'package:kappu/screens/login/login_screen.dart';
import '../../common/customtexts.dart';
import '../../models/serializable_model/forget_password_response.dart';
import '../../net/base_dio.dart';
import '../../net/http_client.dart';
import '../register/widgets/text_field.dart';

class CreateNewPassword extends StatefulWidget {
  final ForgetPasswordResponse forgetPasswordResponse;
  final bool isemailoptedforotp;
  final String otp;
  const CreateNewPassword(
      {Key? key,
      required this.forgetPasswordResponse,
      required this.isemailoptedforotp,
      required this.otp})
      : super(key: key);

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  bool sendingcode = false;
  final _formState = GlobalKey<FormState>();
  bool _showPassword = true;
  bool _showCheckPassword = true;
  String password = '';
  String checkPassword = '';
  String passwordStrength = '';
  bool resetingpassword = false;

  String vaidatePassword(String password) {
    if (password.contains(
        RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{6,}$'))) {
      return 'Strong';
    } else {
      return 'Weak';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: SignUpPainter(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Form(
            key: _formState,
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
                    buttontext: "Create New Password",
                    fontfailmy: 'Montserrat-ExtraBold',
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                30.verticalSpace,
                CustomTextFormField(
                  controller: passwordcontroller,
                  validator: (value) => vaidatePassword(value!) == 'Weak'
                      ? "Must contain at least one Capital letter and a number"
                      : null,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: passwordIcon,
                  showPassword: _showPassword,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _showPassword = !_showPassword;
                        setState(() {});
                      },
                      child: _showPassword
                          ? passwordEyeIcon
                          : passwordGreenEyeIcon),
                  hintText: "Password",
                  onChanged: (value) {
                    password = value;
                    passwordStrength = vaidatePassword(value);
                    setState(() {});
                  },
                ),
                passwordStrength == ''
                    ? SizedBox(height: ScreenUtil().setHeight(5))
                    : Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          right: ScreenUtil().setWidth(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password Strength:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF767F94),
                                  fontSize: ScreenUtil().setSp(13)),
                            ),
                            Text(
                              passwordStrength,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: passwordStrength == 'Weak'
                                      ? Colors.red
                                      : const Color(0xFF05C46B),
                                  fontSize: ScreenUtil().setSp(13)),
                            )
                          ],
                        ),
                      ),
                CustomTextFormField(
                  showPassword: _showCheckPassword,
                  controller: confirmpasswordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    checkPassword = value;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      if (value != passwordcontroller.value.text) {
                        return "Passwords donot match";
                      } else {
                        return null;
                      }
                    } else {
                      return "Enter Your password";
                    }
                  },
                  prefixIcon: passwordIcon,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _showCheckPassword = !_showCheckPassword;
                        setState(() {});
                      },
                      child: _showCheckPassword
                          ? passwordEyeIcon
                          : passwordGreenEyeIcon),
                  hintText: "Confirm Password",
                ),
                30.verticalSpace,
                CustomButton(
                  buttontext: 'Reset Password',
                  isLoading: resetingpassword,
                  onPressed: () async {
                    if (_formState.currentState!.validate()) {
                      if (!resetingpassword) {
                        resetingpassword = true;
                        setState(() {});
                        Map<String, dynamic> body = {
                          'email': widget.forgetPasswordResponse.email,
                          'otp_email': widget.otp,
                          'is_email_opted_for_otp': widget.isemailoptedforotp,
                          'password': passwordcontroller.text
                        };
                        HttpClient()
                            .resetpassword(
                                widget.forgetPasswordResponse.id.toString(),
                                body)
                            .then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        }).catchError((err) {
                          resetingpassword = true;
                          setState(() {});
                          BaseDio.getDioError(err);
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

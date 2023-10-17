import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/button.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/register/widgets/text_field.dart';

import '../../common/painter.dart';
import '../../components/AppColors.dart';
import '../../constants/icons.dart';
import '../../net/base_dio.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordPageState();
  }
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  String password = '';
  String checkPassword = '';
  bool loading = false;
  bool _showPassword = true;
  bool _showCheckPassword = true;
  String passwordStrength = '';
  final _formState = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkPasswordController =
      TextEditingController();

  bool isVaildPassword = true;
  bool isVaildConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(title: "Change Password",

      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Change Password",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))
      ),
      body: SingleChildScrollView(
        child: CustomPaint(
          painter: SignUpPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Form(
                  key: _formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/colorfulLogo.png",
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
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
                        isValid: isVaildPassword,
                        onChanged: (value) {
                          password = value;
                          passwordStrength = vaidatePassword(value);
                          setState(() {});
                          if (value.isNotEmpty &&
                              vaidatePassword(value) == 'Strong') {
                            isVaildPassword = true;
                          } else {
                            isVaildPassword = false;
                          }
                          setState(() {});
                        },
                      ),
                      passwordStrength == ''
                          ? SizedBox(height: ScreenUtil().setHeight(0))
                          : Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        controller: _checkPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        isValid: isVaildConfirm,
                        onChanged: (value) {
                          if (value.isNotEmpty && value == password) {
                            isVaildConfirm = true;
                          } else {
                            isVaildConfirm = false;
                          }
                          checkPassword = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (value != _passwordController.value.text) {
                              return "Passwords do not match";
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
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      CustomButton(
                          buttontext: "Next",
                          isLoading: loading,
                          onPressed: () {
                            onChangepressed();
                          }),
                      10.verticalSpace,

                      // const OrSignUpWith()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String vaidatePassword(String password) {
    if (password.contains(
        RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$'))) {
      return 'Strong';
    } else {
      return 'Weak';
    }
  }

  onChangepressed() async {
    if (_passwordController.text.isEmpty ||
        passwordStrength == 'Weak' ||
        _checkPasswordController.text.isEmpty ||
        _checkPasswordController.text != _passwordController.text) {
      return;
    }
    if (!loading) {
      setState(() {
        this.loading = true;
      });

      await HttpClient().changePassword(_passwordController.text).then((value) {
        loading = false;

        if (value?.data['status']) {
          Navigator.pop(context);
        }
        setState(() {});
      }).catchError((e) {
        setState(() {
          this.loading = false;
        });
        BaseDio.getDioError(e);
      });
    }
  }
}

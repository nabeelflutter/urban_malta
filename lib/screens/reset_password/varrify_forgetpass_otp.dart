import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/painter.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/reset_password/create_new_password.dart';
import '../../models/serializable_model/forget_password_response.dart';
import '../login/login_screen.dart';

class VarifyOtp extends StatefulWidget {
  // final String email;
  // final int id;
  final bool isemailoptedforotp;
  final ForgetPasswordResponse forgetPasswordResponse;

  const VarifyOtp(
      {Key? key,
      required this.forgetPasswordResponse,
      required this.isemailoptedforotp})
      : super(key: key);

  @override
  _VarifyOtpState createState() => _VarifyOtpState();
}

class _VarifyOtpState extends State<VarifyOtp>
    with SingleTickerProviderStateMixin {
  // Constants
  final int time = 30;
  AnimationController? _controller;

  // Variables
  late Size _screenSize;
  late int _currentDigit = -1;
  late int _firstDigit = -1;
  late int _secondDigit = -1;
  late int _thirdDigit = -1;
  late int _fourthDigit = -1;
  bool varifying_otp = false;

  Timer? timer;
  int? totalTimeInSeconds;
  bool? _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  // Returns "Appbar"
  void resetdigits() {
    _currentDigit = -1;
    _firstDigit = -1;
    _secondDigit = -1;
    _thirdDigit = -1;
    _fourthDigit = -1;
    setState(() {});
  }

  // Return "Verification Code" label

  showvarifiedorRejectedDialogue({required bool varified}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: const Text(
            "OTP Varification",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            varified
                ? "Your Email has Varified"
                : "You entered the Incorrect Otp",
            style:
                TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(13)),
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                varified
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()))
                    : Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  showvarifyingAlertDialog() {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: const Text("Varifying OTP"),
        content: SizedBox(
          height: ScreenUtil().setHeight(60),
          width: ScreenUtil().setWidth(200),
          child: Column(
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Return "Email" label
  get _getEmailLabel {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Please enter the Varification Code\n sent on ' +
            (widget.isemailoptedforotp
                ? widget.forgetPasswordResponse.email
                : widget.forgetPasswordResponse.phonenumber),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            color: Colors.grey,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  // Return "OTP" input field
  get _getInputField {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
      ],
    );
  }

  // Returns "OTP" input part
  get _getInputPart {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const BackButton(),
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
        _getEmailLabel,
        _getInputField,
        _hideResendButton! ? _getTimerText : _getResendButton,
        _getOtpKeyboard
      ],
    );
  }

  // Returns "Timer" label
  get _getTimerText {
    return SizedBox(
      height: 32,
      child: Offstage(
        offstage: !_hideResendButton!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.access_time),
            const SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller!, 15.0, Colors.black)
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return InkWell(
      child: Container(
        height: 32,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(32)),
        alignment: Alignment.center,
        child: const Text(
          "Resend OTP",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      onTap: () {
        // Resend you OTP via API or anything
      },
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return SizedBox(
        height: _screenSize.width - 80,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    width: 80.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: const Icon(
                        Icons.backspace,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_fourthDigit != -1) {
                            _fourthDigit = -1;
                          } else if (_thirdDigit != -1) {
                            _thirdDigit = -1;
                          } else if (_secondDigit != -1) {
                            _secondDigit = -1;
                          } else if (_firstDigit != -1) {
                            _firstDigit = -1;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton!;
              });
            }
          });
    _controller!
        .reverse(from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: SignUpPainter(),
        child: SizedBox(
          width: _screenSize.width,
          //        padding:  EdgeInsets.only(bottom: 16.0),
          child: _getInputPart,
        ),
      ),
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: Text(
        digit != -1 ? digit.toString() : "",
        style: const TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      decoration: const BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: Colors.black,
      ))),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton(
      {required String label, required VoidCallback onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton(
      {required Widget label, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == -1) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == -1) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == -1) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == -1) {
        _fourthDigit = _currentDigit;

        var otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();
        showvarifyingAlertDialog();
        Map<String, dynamic> body = {
          'email': widget.forgetPasswordResponse.email,
          'is_email_opted_for_otp': widget.isemailoptedforotp,
          'otp_email': widget.isemailoptedforotp ? otp : "",
          'otp_sms': widget.isemailoptedforotp ? "" : otp
        };
        // ApiBaseHelper().signup(params: body);

        HttpClient().variftyemailOrPhoneOTP(body).then((value) {
          Navigator.pop(context);
          resetdigits();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateNewPassword(
                        forgetPasswordResponse: widget.forgetPasswordResponse,
                        isemailoptedforotp: widget.isemailoptedforotp,
                        otp: otp,
                      )));
        }).catchError((error) {
          resetdigits();
          Navigator.pop(context);
          showvarifiedorRejectedDialogue(varified: false);
        });
        // Verify your otp by here. API call
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const PhoneConfirmed(
        //               varified: false,
        //             )));
      }
    });
  }

  Future<void> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller!
        .reverse(from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
  }

  void clearOtp() {
    _fourthDigit = 0;
    _thirdDigit = 0;
    _secondDigit = 0;
    _firstDigit = 0;
    setState(() {});
  }
}

// ignore: must_be_immutable
class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor, {Key? key})
      : super(key: key);

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration!;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Text(
            timerString,
            style: TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}

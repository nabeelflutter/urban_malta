import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/AppColors.dart';

class WarningDialog2Box extends StatefulWidget {
  /// Creates a widget combines of  [Container].
  /// [title], [descriptions], [onPressed] must not be null.
  ///
  /// This widget will return dialog to show warning.
  /// For e.g. when user tap on report user icon will show [WarningDialogBox] to warn user about the action.
  const WarningDialog2Box({
    Key? key,
    required this.title,
    required this.icon,
    required this.descriptions,
    required this.buttonTitle,
    required this.onPressed,
    this.buttonColor = AppColors.red,
  }) : super(key: key);

  final String title, descriptions, buttonTitle;
  final Color buttonColor;
  final IconData icon;
  final Function() onPressed;

  @override
  _WarningDialog2BoxState createState() => _WarningDialog2BoxState();
}

class _WarningDialog2BoxState extends State<WarningDialog2Box> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pop(context);
    });
    // final w = MediaQuery.of(context).size.width;
    // final h = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  Container contentBox(context) {
    return  Container(
      height: MediaQuery.of(context).size.height * 0.3,
      // width: 350,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),

          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle

            ),
            child: Icon(widget.icon ,color: Colors.white),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
              widget.title,
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                  )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(widget.descriptions,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),









        ],
      ),
    );
  }
}


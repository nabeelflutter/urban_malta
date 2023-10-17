// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {Key? key,
      required this.name,
      required this.backgroundColor,
      required this.textColor})
      : super(key: key);

  final String name;
  final Color? backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        // focusColor: backgroundColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
        ),
        // prefixIcon: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 12),
        //   child: Icon(Icons.email, size: 20),
        // ),
        hintText: name,
        fillColor: backgroundColor,
        filled: true,
        contentPadding: const EdgeInsets.only(left: 20),
        hintStyle: TextStyle(
         
          fontSize: 15.sp,
          color: textColor,
        ),
      ),
    );
  }
}

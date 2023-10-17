// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/AppColors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String addGigTitle;
  final String? Function(String?) validator;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final TextInputType keyboardType;
  bool showPassword;
  final Color? bordercolor;
  final int? maxlines;
  final bool? enabled;
  final bool? isValid;
  final TextStyle? hintTextStyle;
  final EdgeInsets? padding;
  final bool? isTransparent;

  CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      this.addGigTitle = '',
      this.readOnly = false,
      required this.keyboardType,
      this.showPassword = false,
      this.isValid = false,
      this.bordercolor,
      this.maxlines = 1,
      this.enabled = true,
      this.hintTextStyle,
      this.padding,
      this.isTransparent})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    // print(widget.addGigTitle);
    return Padding(
        padding: widget.padding ?? EdgeInsets.only(bottom: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Material(
            borderRadius: BorderRadius.circular(25),
            //     // elevation: 3,
            color: widget.isTransparent ?? false
                ? Colors.transparent
                : const Color(0xfff1f1f1),
            child: Container(
                // decoration: BoxDecoration(
                //   // color: Colors.white,
                //   // borderRadius: BorderRadius.circular(25),
                //   // boxShadow: [
                //   //   BoxShadow(
                //   //     color: Colors.grey.withOpacity(0.5),
                //   //     spreadRadius: 2,
                //   //     blurRadius: 2,
                //   //     offset: Offset(1, 1), // changes the shadow position
                //   //   ),
                //   // ],
                // ),
                child: TextFormField(
                    enabled: widget.enabled,
                    cursorColor: widget.bordercolor ?? Colors.black,
                    maxLines: widget.maxlines,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    obscuringCharacter: '*',
                    readOnly: widget.readOnly!,
                    obscureText: widget.showPassword,
                    style: TextStyle(
                        color: Colors.black,
                        //  fontFamily: "Montserrat-Medium"
                         ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding:
                            //EdgeInsets.only(left: 15, top: 0),
                            const EdgeInsetsDirectional.only(
                                start: 15, end: 10),
                        child: widget.prefixIcon,
                      ),
                      prefixIconConstraints:
                          BoxConstraints(maxHeight: ScreenUtil().setWidth(25)),
                      suffixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 10, end: 10),
                        child: widget.suffixIcon,
                      ),
                      suffixIconConstraints:
                          const BoxConstraints(maxHeight: 25),
                      hintText: widget.hintText,
                      hintStyle: widget.hintTextStyle ??
                          TextStyle(
                            color: widget.bordercolor,
                            // color: Colors.black,
                            // fontFamily: "Montserrat-Medium",
                            fontFamily: 'Raleway',
                            fontSize: ScreenUtil().setSp(14),
                          ),
                      errorStyle: TextStyle(
                          color: Colors.red,
                          wordSpacing: 5.0,
                          // fontFamily: "Montserrat-Regular"
                          ),
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 3, top: 10, bottom: 10),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      widget.onChanged!(value);
                    })),
          ),
          if (!widget.isValid!)
            if (widget.hintText != "" || widget.addGigTitle == "yes")
              Text(
                widget.addGigTitle != "yes"
                    ? widget.hintText != ""
                        ? 'Please enter ' + widget.hintText.toLowerCase()
                        : ""
                    : "Write a Title for your GiG",
                style: const TextStyle(color: AppColors.red),
              )
        ]));
  }
}

class ElevatedTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  bool showPassword;
  final Color? bordercolor;
  final int? maxlines;
  final bool? enabled;
  final bool? isValid;

  ElevatedTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      required this.keyboardType,
      this.showPassword = false,
      this.isValid = false,
      this.bordercolor,
      this.maxlines = 1,
      this.enabled = true})
      : super(key: key);

  @override
  _ElevatedTextFormFieldState createState() => _ElevatedTextFormFieldState();
}

class _ElevatedTextFormFieldState extends State<ElevatedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          borderRadius: BorderRadius.circular(25),
          elevation: 3,
          shadowColor: Colors.black.withOpacity(0.14),
          child: TextFormField(
              enabled: widget.enabled,
              cursorColor: widget.bordercolor ?? Colors.black,
              maxLines: widget.maxlines,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscuringCharacter: '*',
              obscureText: widget.showPassword,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(start: 20, end: 15),
                    child: widget.prefixIcon,
                  ),
                  suffixIcon: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: widget.suffixIcon,
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: widget.bordercolor,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(14),
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none),
              onChanged: widget.onChanged),
        ),
        if (!widget.isValid!)
          Text(
            'Please enter your ' + widget.hintText.toLowerCase(),
            style: const TextStyle(color: AppColors.red),
          )
      ],
    );
  }
}

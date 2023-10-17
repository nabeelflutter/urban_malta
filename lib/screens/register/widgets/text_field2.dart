import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/AppColors.dart';

class CustomTextFormField2 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

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

  CustomTextFormField2(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly = false,
      required this.keyboardType,
      this.showPassword = false,
      this.isValid = false,
      this.bordercolor,
      this.maxlines = 1,
      this.enabled = true})
      : super(key: key);

  @override
  _CustomTextFormFieldState2 createState() => _CustomTextFormFieldState2();
}

class _CustomTextFormFieldState2 extends State<CustomTextFormField2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Material(
              borderRadius: BorderRadius.circular(25),
              // elevation: 0.01,
              color: const Color(0xfff1f1f1),
              // shadowColor: Colors.transparent,
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
                      color: Colors.black, fontFamily: "Montserrat-Medium"),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 15, end: 10),
                      child: widget.prefixIcon,
                    ),
                    prefixIconConstraints:
                        BoxConstraints(maxHeight: ScreenUtil().setWidth(25)),
                    suffixIcon: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 10, end: 10),
                      child: widget.suffixIcon,
                    ),
                    suffixIconConstraints: const BoxConstraints(maxHeight: 25),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
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
          if (!widget.isValid!)
            Text(
              'Please enter valid email',
              style: const TextStyle(color: AppColors.red),
            )
        ]));
  }
}

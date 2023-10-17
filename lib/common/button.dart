import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';

class CustomButton extends StatefulWidget {
  final dynamic onPressed;
  final String buttontext;
  final bool isLoading;
  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttontext,
      required this.isLoading,
      Container? child})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if(!widget.isLoading)
          widget.onPressed();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.app_color,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: widget.isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  widget.buttontext,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatefulWidget {
  final dynamic onPressed;
  final String buttontext;
  final bool isLoading;
  final Color backGroundColor;
  final IconData rightIcon;
  final double borderRadius;
  final double height;

  const CustomButtonWithIcon(
      {Key? key,
      this.onPressed,
      required this.buttontext,
      required this.isLoading,
      required this.backGroundColor,
      required this.rightIcon,
      required this.borderRadius,
      required this.height})
      : super(key: key);

  @override
  State<CustomButtonWithIcon> createState() => _CustomButtonWithIconState();
}

class _CustomButtonWithIconState extends State<CustomButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onPressed();
      },
      child: Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.backGroundColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    widget.buttontext,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
            50.horizontalSpace,
            Icon(
              widget.rightIcon,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

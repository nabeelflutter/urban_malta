import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 
class CustomBookingButton extends StatefulWidget {
  final dynamic onPressed;
  final String buttontext;
  final bool isLoading;
  final Color color;
  const CustomBookingButton(
      {Key? key,
      this.onPressed,
      required this.buttontext,
      required this.isLoading,
      required this.color})
      : super(key: key);

  @override
  State<CustomBookingButton> createState() => _CustomBookingButtonState();
}

class _CustomBookingButtonState extends State<CustomBookingButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onPressed();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Container(
          height: ScreenUtil().setHeight(35),
          width: ScreenUtil().setWidth(300),
          decoration: BoxDecoration(
              border: Border.all(color: widget.color, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: widget.isLoading
                ? CircularProgressIndicator(
                    color: widget.color,
                  )
                : Text(
                    widget.buttontext,
                    style: TextStyle(
                        color: widget.color,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kappu/components/AppColors.dart';

class CustomProgressBar extends StatelessWidget {
 const CustomProgressBar(
      {Key ?key,
      this.valueColor = AppColors.app_color})
      : super(key: key);
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Center(child:Container(
      margin: const EdgeInsets.only(top:300),
      width: 50,
      height: 50,
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(valueColor)),
        )
    ));
  }
}

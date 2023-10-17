import 'package:flutter/material.dart';

void changeScreen({required BuildContext context,required Widget screen}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main_context.dart';

showAlertDialog({required String errorType, required String error}) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    title: Text(
      errorType,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    content: Text(
      error,
      style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(13)),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: NavigationService.navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

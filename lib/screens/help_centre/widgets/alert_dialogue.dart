import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showaskedDialog(BuildContext context) {
  // set up the buttons

  Widget continueButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Thanks !",
      style: TextStyle(
          fontSize: ScreenUtil().setSp(16),
          color: Colors.black,
          fontWeight: FontWeight.bold),
    ),
    content: Text(
      "It might take us one to two days to answer your Question ! And we will mail you. Thanks",
      style: TextStyle(
          fontSize: ScreenUtil().setSp(13),
          color: Colors.grey,
          fontWeight: FontWeight.w600),
    ),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

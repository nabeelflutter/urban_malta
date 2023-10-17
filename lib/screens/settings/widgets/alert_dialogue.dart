import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Phoenix.rebirth(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Logout?",
      style: TextStyle(
          fontSize: ScreenUtil().setSp(16),
          color: Colors.black,
          fontWeight: FontWeight.bold),
    ),
    content: Text(
      "Are You sure You want to Logout?",
      style: TextStyle(
          fontSize: ScreenUtil().setSp(12),
          color: Colors.grey,
          fontWeight: FontWeight.w600),
    ),
    actions: [
      cancelButton,
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

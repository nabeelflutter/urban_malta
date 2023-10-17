import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

showNotificationOverlay({
  required String title,
  required String subtitle,
  Duration? duration,
}) {
  showOverlayNotification(
    (context) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
            ),
          ),
        ),
      );
    },
    duration: duration,
  );
}

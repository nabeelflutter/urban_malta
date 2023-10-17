import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showSuccessFlushBar({required BuildContext context, required String message}) {
  return Flushbar(
    icon: const Icon(
      Icons.check_circle,
      color: Colors.green,
    ),
    shouldIconPulse: false,
    animationDuration: const Duration(seconds: 1),
    backgroundColor: Colors.black54,
    message: message,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    flushbarStyle: FlushbarStyle.FLOATING,
    duration: const Duration(seconds: 3),
  ).show(context);
}

showCautionFlushBar({required BuildContext context, required String message}) {
  return Flushbar(
    icon: const Icon(
      Icons.warning_rounded,
      color: Colors.amber,
    ),
    shouldIconPulse: false,
    animationDuration: const Duration(seconds: 1),
    backgroundColor: Colors.black54,
    message: message,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    flushbarStyle: FlushbarStyle.FLOATING,
    duration: const Duration(seconds: 3),
  ).show(context);
}

showErrorFlushBar({required BuildContext context, required String message}) {
  return Flushbar(
    icon: const Icon(
      Icons.cancel,
      color: Colors.red,
    ),
    shouldIconPulse: false,
    animationDuration: const Duration(seconds: 1),
    backgroundColor: Colors.black54,
    message: message,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    flushbarStyle: FlushbarStyle.FLOATING,
    duration: const Duration(seconds: 3),
  ).show(context);
}

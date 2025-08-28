import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

void successSnackBar({
  required String message,
  required BuildContext context,
  bool displayIcon = false,
}) {
  CherryToast.success(
    animationType: AnimationType.fromTop,
    displayIcon: displayIcon,
    title: Text(
      message,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  ).show(context);
}

void informationSnackBar({
  required BuildContext context,
  required String message,
  required Text? action,
  required String title,
  bool displayIcon = false,
}) {
  CherryToast.info(
    animationType: AnimationType.fromTop,
    action: action,
    displayIcon: displayIcon,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  ).show(context);
}

void failedSnackbar({
  required BuildContext context,
  required String text,
  required Text? action,
  bool displayIcon = false,
}) {
  CherryToast.error(
    animationType: AnimationType.fromTop,
    action: action,
    displayIcon: displayIcon,
    title: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  ).show(context);
}

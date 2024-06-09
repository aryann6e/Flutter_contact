import 'package:flutter/material.dart';

ScaffoldFeatureController snackbar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.fixed,
    ),
  );
}

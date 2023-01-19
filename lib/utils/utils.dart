import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Utils {

  // Snack bar Message Tab
  static showSnackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xff3F51B5),
        content: Text(message),
      ),
    );
  }

  static showDialogMessage(String message, BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(
          child: Text(
            message,
            style: const TextStyle(
              color: Color(0xff3F51B5),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

showSnackbar(context, text, {Color? color}) {
  var snackBar = SnackBar(
    content: Text('$text'),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

customLoading() {
  return const CircularProgressIndicator(
    color: Colors.white,
  );
}

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
  return CircularProgressIndicator(
    color: Colors.lightBlue[800]!,
  );
}

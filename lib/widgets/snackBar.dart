import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: Duration(milliseconds: 2000),
    elevation: 10,
    shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: Colors.blue,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

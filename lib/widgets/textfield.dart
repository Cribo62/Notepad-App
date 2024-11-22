import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserTextField extends StatelessWidget {
  const UserTextField({
    Key? key,
    required this.fieldcontroller,
    required this.label,
    required this.keyboard,
  }) : super(key: key);

  final TextEditingController fieldcontroller;
  final String label;
  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: fieldcontroller,
        keyboardType: keyboard,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          labelText: label,
        ),
      ),
    );
  }
}

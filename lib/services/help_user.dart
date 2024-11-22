import 'package:assignment_2/routes/route.dart';
import 'package:assignment_2/services/user_service.dart';
import 'package:assignment_2/widgets/snackBar.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void createNewUser(BuildContext context,
    {required String email,
    required String password,
    required String name}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty || name.isEmpty || password.isEmpty) {
    showSnackBar(context, 'Please enter fields');
  } else {
    BackendlessUser user = BackendlessUser()
      ..email = email.trim()
      ..password = password.trim()
      ..putProperties({'name': name.trim()});

    String result = await context.read<User>().createUser(user);
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, 'New User Created');
      Navigator.pop(context);
    }
  }
}

void loginUserUI(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'Please Enter All Fields');
  } else {
    String result = await context.read<User>().loginUser(
          email.trim(),
          password.trim(),
        );
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      Navigator.of(context).popAndPushNamed(Routing.UnitPage);
    }
  }
}

void logoutUserUI(BuildContext context) async {
  String result = await context.read<User>().logoutUser();
  if (result == 'OK') {
    context.read<User>().setActiveUserNull();
    Navigator.popAndPushNamed(context, Routing.LoginPage);
  } else {
    showSnackBar(context, result);
  }
}

void resetPasswordUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context, 'Please Enter your Email Address And Press Reset');
  } else {
    String result = await context.read<User>().resetPassword(email.trim());
    if (result == 'OK') {
      showSnackBar(context, 'Password Reset Request Successfully Reset');
    } else {
      showSnackBar(context, result);
    }
  }
}

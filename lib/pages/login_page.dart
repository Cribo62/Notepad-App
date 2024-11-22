import 'package:assignment_2/routes/route.dart';
import 'package:assignment_2/services/help_user.dart';
import 'package:assignment_2/services/user_service.dart';
import 'package:assignment_2/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../widgets/textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //
  //Controllers:
  late TextEditingController nameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //
        //Background Page Decoration:
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.pink]),
        ),
        child: Stack(children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  //
                  //User Text Field Widget That Stores The Email Of User:
                  UserTextField(
                    keyboard: TextInputType.emailAddress,
                    fieldcontroller: nameController,
                    label: 'Please Enter Email Address',
                  ),
                  //
                  //User Text Field Widget That Stores The Password Of User:
                  UserTextField(
                    keyboard: TextInputType.text,
                    fieldcontroller: passwordController,
                    label: 'Please Enter Your Password',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    //
                    //Button Makes Use Of The Login Function (in help_user.dart):
                    child: ElevatedButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.pink),
                      onPressed: () {
                        loginUserUI(context,
                            email: nameController.text,
                            password: passwordController.text);
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  //
                  //Button That Routes To the Register Page:
                  ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.pink),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routing.RegisterPage);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  //
                  //Button To Request A Password Reset(help_user Function):
                  ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.pink),
                    onPressed: () async {
                      resetPasswordUI(context, email: nameController.text);
                    },
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Selector<User, Tuple2>(
            selector: (context, value) =>
                Tuple2(value.showProgress, value.progressText),
            builder: (context, value, child) {
              return value.item1
                  ? AppProgressIndicator(text: '${value.item2}')
                  : Container();
            },
          )
        ]),
      ),
    );
  }
}

import 'package:assignment_2/services/help_user.dart';
import 'package:assignment_2/services/user_service.dart';
import 'package:assignment_2/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../widgets/textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //
  //Controllers for the textfields to be used:
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;

//
//Initializing the Controllers:
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            //
            //Background Decoration:
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.pink],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        'Registration',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Focus(
                      onFocusChange: (value) async {
                        if (!value) {
                          context
                              .read<User>()
                              .checkIfUserExists(emailController.text.trim());
                        }
                      },
                      //
                      //Text Field Widget:
                      child: UserTextField(
                        keyboard: TextInputType.text,
                        fieldcontroller: nameController,
                        label: 'Enter Your Name',
                      ),
                    ),
                    //
                    //Text Field Widget:
                    UserTextField(
                      keyboard: TextInputType.emailAddress,
                      fieldcontroller: emailController,
                      label: 'Enter Your Email Address',
                    ),
                    //
                    //Function Used to check if user already exists in database:
                    Selector<User, bool>(
                        selector: (context, value) => value.userExists,
                        builder: (context, value, child) {
                          return value
                              ? const Text(
                                  'Email already exists, register with another',
                                  style: TextStyle(color: Colors.red),
                                )
                              : Container();
                        }),
                    //
                    //Text Field Widget:
                    UserTextField(
                      fieldcontroller: passwordController,
                      label: 'Enter Your Password',
                      keyboard: TextInputType.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      //
                      //Button to create a new user(function in help_user.dart):
                      child: ElevatedButton(
                        onPressed: () {
                          createNewUser(
                            context,
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            name: nameController.text.trim(),
                          );
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 30,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 30,
                color: Colors.white,
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
              }),
        ],
      ),
    );
  }
}

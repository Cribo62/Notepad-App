import 'package:assignment_2/init.dart';
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    InitApp.initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //Background Decoration for the loading page
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.pink]),
          ),
          child: Column(
            //Wrapping the Loading Icon in a Column to Center the Icon on the Screen
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rocket_launch_rounded,
                color: Colors.red,
                size: 80,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Loading',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

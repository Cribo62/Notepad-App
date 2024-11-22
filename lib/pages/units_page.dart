import 'package:assignment_2/services/help_user.dart';
import 'package:assignment_2/services/user_service.dart';
import 'package:assignment_2/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class Unit extends StatefulWidget {
  const Unit({Key? key}) : super(key: key);

  @override
  State<Unit> createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  late TextEditingController unitController;

  @override
  void initState() {
    super.initState();
    unitController = TextEditingController();
  }

  @override
  void dispose() {
    unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.pink]),
        ),
        child: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        logoutUserUI(context);
                      },
                      icon: const Icon(
                        Icons.exit_to_app_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Unit Reflections',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          Selector<User, Tuple2>(
              selector: (context, value) =>
                  Tuple2(value.showProgress, value.progressText),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(text: value.item2)
                    : Container();
              })
        ]),
      ),
    );
  }
}

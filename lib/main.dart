import 'package:assignment_2/routes/route.dart';
import 'package:assignment_2/services/units_service.dart';
import 'package:assignment_2/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => User(),
        ),
        ChangeNotifierProvider(
          create: (context) => UnitsService(),
        )
      ],
      child: const MaterialApp(
        initialRoute: Routing.LoadingPage,
        onGenerateRoute: Routing.createRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

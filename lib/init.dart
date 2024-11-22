import 'package:assignment_2/routes/route.dart';
import 'package:assignment_2/services/user_service.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitApp {
  static final String apiKeyAndroid = '136A017D-3AAD-4762-9981-7B80429C45D9';
  static final String apiKeyIOS = 'D6866164-D8A1-4D27-997B-3E43A6D028C9';
  static final String appID = '334CE446-5242-CB8F-FF69-CAFD9B777D00';

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        applicationId: appID,
        iosApiKey: apiKeyIOS,
        androidApiKey: apiKeyAndroid);
    String result = await context.read<User>().checkIfUserLoggedIn();
    if (result == 'Ok') {
      Navigator.popAndPushNamed(context, Routing.UnitPage);
    } else {
      Navigator.popAndPushNamed(context, Routing.LoginPage);
    }
  }
}

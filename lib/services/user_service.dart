import 'package:assignment_2/models/unit_entry.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  BackendlessUser? _activeUser;
  BackendlessUser? get activeUser => _activeUser;

  void setActiveUserNull() {
    _activeUser = null;
  }

  bool _userExists = false;
  bool get userExists => _userExists;

  set userExists(bool value) {
    userExists = value;
    notifyListeners();
  }

  bool _showProgress = false;
  bool get showProgress => _showProgress;

  String _progressText = '';
  String get progressText => _progressText;

  Future<String> resetPassword(String name) async {
    String result = 'OK';
    _showProgress = true;
    _progressText = 'Processing Reset Request....';
    notifyListeners();
    await Backendless.userService
        .restorePassword(name)
        .onError((error, stackTrace) {
      result = ErrorMessage(error.toString());
    });
    _showProgress = false;
    notifyListeners();
    return result;
  }

  Future<String> loginUser(String name, String password) async {
    String result = 'OK';

    _showProgress = true;
    _progressText = 'Logging in... this may take a moment';
    notifyListeners();
    BackendlessUser? user = await Backendless.userService
        .login(name, password, true)
        .onError((error, stackTrace) {
      result = ErrorMessage(error.toString());
    });
    if (user != null) {
      _activeUser = user;
    }
    _showProgress = false;
    notifyListeners();
    return result;
  }

  Future<String> logoutUser() async {
    String result = 'OK';

    _showProgress = true;
    _progressText = 'Logging Out... ';
    notifyListeners();

    await Backendless.userService.logout().onError((error, stackTrace) {
      result = error.toString();
    });
    _showProgress = false;
    notifyListeners();
    return result;
  }

  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';

    bool? validLog = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      result = error.toString();
    });
    if (validLog != null && validLog) {
      String? activeUserObjectID = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        result = error.toString();
      });
      if (activeUserObjectID != null) {
        Map<dynamic, dynamic>? mapOfActiveUser = await Backendless.data
            .of("Users")
            .findById(activeUserObjectID)
            .onError((error, stackTrace) {
          result = error.toString();
        });
        if (mapOfActiveUser != null) {
          _activeUser = BackendlessUser.fromJson(mapOfActiveUser);
          notifyListeners();
        } else {
          result = 'NOT OK';
        }
      } else {
        result = 'NOT OK';
      }
    } else {
      result = 'NOT OK';
    }
    return result;
  }

  void checkIfUserExists(String emailName) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$emailName'";

    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.length == 0) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<String> createUser(BackendlessUser user) async {
    String result = 'OK';

    _showProgress = true;
    _progressText = 'Creating a new User';
    notifyListeners();

    try {
      await Backendless.userService.register(user);
      UnitEntry emptyEntry = UnitEntry(
        units: {},
        email: user.email,
        password: user.password,
      );
      await Backendless.data
          .of('UnitEntry')
          .save(emptyEntry.toJson())
          .onError((error, stackTrace) {
        result = error.toString();
      });
    } catch (ex) {
      result = ErrorMessage(ex.toString());
    }
    _showProgress = false;
    notifyListeners();
    return result;
  }

  String ErrorMessage(String message) {
    if (message.contains('Email confirmation needed')) {
      return 'Check your email inbox for confirmation';
    }
    if (message.contains('User already exists')) {
      return 'User already exists. Create a new user account or login';
    }
    if (message.contains('Invalid login or password entered')) {
      return 'Check Name or Password and try again';
    }
    if (message
        .contains('User account is locked out. Too many failed attempts')) {
      return 'Locked out, Please try again in 30minutes';
    }
    if (message.contains('Unable to find account')) {
      return 'This email does not exist, Try Again';
    }
    if (message.contains('Connection to Server Error')) {
      return 'Check your Internet connection and Try again ';
    }
    return message;
  }
}

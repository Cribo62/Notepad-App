import 'package:assignment_2/models/units.dart';
import 'package:assignment_2/pages/units_page.dart';
import 'package:assignment_2/services/units_service.dart';
import 'package:assignment_2/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//void refreshUnitsInUI(BuildContext context) async {}

void saveUnitUI(BuildContext context) async {}

void createNewUnitUI(BuildContext context,
    {required TextEditingController unitController}) async {
  if (unitController.text.isEmpty) {
    showSnackBar(context, 'Please Enter a Unit');
  } else {
    Units units = Units(
      unitDesc: unitController.text.trim(),
      //reflections: unitController.text,
      created: DateTime.now(),
    );
    if (context.read<UnitsService>().units.contains(units)) {
      showSnackBar(context, 'Duplicate Unit... Try Again');
    } else {
      unitController.text = '';
      context.read<UnitsService>().createUnit(units);
      Navigator.pop(context);
    }
  }
}

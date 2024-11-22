import 'package:assignment_2/models/units.dart';
import 'package:flutter/material.dart';

import '../models/unit_entry.dart';

class UnitsService with ChangeNotifier {
  UnitEntry? _unitEntry;

  List<Units> _units = [];
  List<Units> get units => _units;

  void emptyUnits() {
    _units = [];
    notifyListeners();
  }

  bool _retrievingData = false;
  bool _savingData = false;

  bool get retrievingData => _retrievingData;
  bool get savingData => _savingData;

  Future<String> getUnits(String name) async {
    String result = 'OK';
    return result;
  }

  Future<String> saveUnitsEntry(String name, bool inUI) async {
    String result = 'OK';
    return result;
  }

  void UnitsDone(int index) {
    _units[index].done = !_units[index].done;
    notifyListeners();
  }

  void createUnit(Units units) {
    _units.insert(0, units);
    notifyListeners();
  }

  void deleteUnit(Units units) {
    _units.remove(units);
    notifyListeners();
  }
}

Map<dynamic, dynamic> convertUnitsToMap(List<Units> units) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < units.length; i++) {
    map.addAll({'$i': units[i].toJson()});
  }
  return map;
}

List<Units> convertMapToUnits(Map<dynamic, dynamic> map) {
  List<Units> units = [];
  for (var i = 0; i < map.length; i++) {
    units.add(Units.fromJson(map['$i']));
  }
  return units;
}

class Units {
  final String unitDesc;
  //final String reflections;
  bool done;
  final DateTime created;

  Units(
      {required this.unitDesc,
      //required this.reflections,
      this.done = false,
      required this.created});

  Map<String, Object?> toJson() => {
        'unitDesc': unitDesc,
        //'reflections': reflections,
        'done': done ? 1 : 0,
        'created': created.millisecondsSinceEpoch,
      };

  static Units fromJson(Map<dynamic, dynamic>? json) => Units(
      unitDesc: json!['unitDesc'] as String,
      //reflections: json['reflections'] as String,
      done: json['done'] == 1 ? true : false,
      created: DateTime.fromMillisecondsSinceEpoch(
          (json['created'] as double).toInt()));

  @override
  bool operator ==(covariant Units units) {
    return (this
            .unitDesc
            .toUpperCase()
            .compareTo(units.unitDesc.toUpperCase()) ==
        0);
  }

  @override
  int get hashCode {
    return unitDesc.hashCode;
  }
}

class UnitEntry {
  Map<dynamic, dynamic> units;
  String email;
  String password;
  // String username;
  String? objectId;
  DateTime? created;
  DateTime? updated;

  UnitEntry(
      {required this.units,
      required this.email,
      required this.password,
      // required this.username,
      this.objectId,
      this.created,
      this.updated});

  Map<String, Object?> toJson() => {
        'email': email,
        'units': units,
        //'name': username,
        'password': password,
        'objectId': objectId,
        'created': created,
        'updated': updated,
      };

  static UnitEntry fromJson(Map<dynamic, dynamic>? json) => UnitEntry(
      units: json!['units'] as Map<dynamic, dynamic>,
      email: json['email'] as String,
      //username: json['name'] as String,
      password: json['password'] as String,
      objectId: json['objectId'] as String,
      created: json['created'] as DateTime);
}

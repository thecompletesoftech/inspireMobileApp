// To parse this JSON data, do
//
//     final loginmodel = loginmodelFromJson(jsonString);

import 'dart:convert';

Loginmodel loginmodelFromJson(String str) =>
    Loginmodel.fromJson(json.decode(str));

String loginmodelToJson(Loginmodel data) => json.encode(data.toJson());

class Loginmodel {
  int id;
  String username;
  String email;
  dynamic extensionNumber;
  DateTime dateOfBirth;
  bool isActive;
  dynamic unitId;
  String token;

  Loginmodel({
    required this.id,
    required this.username,
    required this.email,
    required this.extensionNumber,
    required this.dateOfBirth,
    required this.isActive,
    required this.unitId,
    required this.token,
  });

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        extensionNumber: json["extension_number"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        isActive: json["is_active"],
        unitId: json["unit_id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "extension_number": extensionNumber,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "is_active": isActive,
        "unit_id": unitId,
        "token": token,
      };
}

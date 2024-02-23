// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  String? message;
  int? status;

  ErrorModel({this.status, this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      ErrorModel(message: json["message"], status: json["status"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}

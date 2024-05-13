// To parse this JSON data, do
//
//     final inspectorModel = inspectorModelFromJson(jsonString);

import 'dart:convert';

InspectorModel inspectorModelFromJson(String str) =>
    InspectorModel.fromJson(json.decode(str));

String inspectorModelToJson(InspectorModel data) => json.encode(data.toJson());

class InspectorModel {
  String type;
  Inspector inspector;

  InspectorModel({
    required this.type,
    required this.inspector,
  });

  factory InspectorModel.fromJson(Map<String, dynamic> json) => InspectorModel(
        type: json["type"],
        inspector: Inspector.fromJson(json["inspector"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "inspector": inspector.toJson(),
      };
}

class Inspector {
  int id;
  int externalAccountId;
  dynamic externalPersonalId;
  String name;

  Inspector({
    required this.id,
    required this.externalAccountId,
    required this.externalPersonalId,
    required this.name,
  });

  factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
        id: json["id"],
        externalAccountId: json["external_account_id"],
        externalPersonalId: json["external_personal_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "external_account_id": externalAccountId,
        "external_personal_id": externalPersonalId,
        "name": name,
      };
}

// To parse this JSON data, do
//
//     final inspectionTypeResModel = inspectionTypeResModelFromJson(jsonString);

import 'dart:convert';

import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';

InspectionTypeResModel inspectionTypeResModelFromJson(String str) =>
    InspectionTypeResModel.fromJson(json.decode(str));

String inspectionTypeResModelToJson(InspectionTypeResModel data) =>
    json.encode(data.toJson());

class InspectionTypeResModel {
  String? type;
  List<InspectionType>? inspectionTypes;

  InspectionTypeResModel({
    this.type,
    this.inspectionTypes,
  });

  factory InspectionTypeResModel.fromJson(Map<String, dynamic> json) =>
      InspectionTypeResModel(
        type: json["type"],
        inspectionTypes: json["inspection_types"] == null
            ? []
            : List<InspectionType>.from(json["inspection_types"]!
                .map((x) => InspectionType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "inspection_types": inspectionTypes == null
            ? []
            : List<dynamic>.from(inspectionTypes!.map((x) => x.toJson())),
      };
}

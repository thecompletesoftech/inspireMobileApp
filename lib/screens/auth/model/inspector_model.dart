// To parse this JSON data, do
//
//     final inspectorModel = inspectorModelFromJson(jsonString);

import 'dart:convert';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';

InspectorModel inspectorModelFromJson(String str) =>
    InspectorModel.fromJson(json.decode(str));

String inspectorModelToJson(InspectorModel data) => json.encode(data.toJson());

class InspectorModel {
  String type;
  Inspector inspector;

  InspectorModel({required this.type, required this.inspector});

  factory InspectorModel.fromJson(Map<String, dynamic> json) => InspectorModel(
        type: json["type"],
        inspector: Inspector.fromJson(json["inspector"]),
      );

  Map<String, dynamic> toJson() =>
      {"type": type, "inspector": inspector.toJson()};
}

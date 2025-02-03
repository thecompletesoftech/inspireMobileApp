// To parse this JSON data, do
//
//     final getFindingTypeResponseModel = getFindingTypeResponseModelFromJson(jsonString);

import 'dart:convert';

GetFindingTypeResponseModel getFindingTypeResponseModelFromJson(String str) =>
    GetFindingTypeResponseModel.fromJson(json.decode(str));

String getFindingTypeResponseModelToJson(GetFindingTypeResponseModel data) =>
    json.encode(data.toJson());

class GetFindingTypeResponseModel {
  String? type;
  List<List<dynamic>>? findingTypes;

  GetFindingTypeResponseModel({
    this.type,
    this.findingTypes,
  });

  factory GetFindingTypeResponseModel.fromJson(Map<String, dynamic> json) =>
      GetFindingTypeResponseModel(
        type: json["type"],
        findingTypes: json["finding_types"] == null
            ? []
            : List<List<dynamic>>.from(json["finding_types"]!
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "finding_types": findingTypes == null
            ? []
            : List<dynamic>.from(
                findingTypes!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

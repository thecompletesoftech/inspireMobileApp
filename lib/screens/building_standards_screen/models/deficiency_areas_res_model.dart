// To parse this JSON data, do
//
//     final deficiencyAreasResponseModel = deficiencyAreasResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:public_housing/screens/deficiencies_inside_screen/models/deficiency_inspections_req_model.dart';

DeficiencyAreasResponseModel deficiencyAreasResponseModelFromJson(String str) =>
    DeficiencyAreasResponseModel.fromJson(json.decode(str));

String deficiencyAreasResponseModelToJson(DeficiencyAreasResponseModel data) =>
    json.encode(data.toJson());

class DeficiencyAreasResponseModel {
  String? type;
  List<DeficiencyArea>? deficiencyAreas;

  DeficiencyAreasResponseModel({
    this.type,
    this.deficiencyAreas,
  });

  factory DeficiencyAreasResponseModel.fromJson(Map<String, dynamic> json) =>
      DeficiencyAreasResponseModel(
        type: json["type"],
        deficiencyAreas: json["deficiency_areas"] == null
            ? []
            : List<DeficiencyArea>.from(json["deficiency_areas"]!
                .map((x) => DeficiencyArea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "deficiency_areas": deficiencyAreas == null
            ? []
            : List<dynamic>.from(deficiencyAreas!.map((x) => x.toJson())),
      };
}

class DeficiencyArea {
  int? id;
  String? name;
  String? definition;
  String? purpose;
  String? commonComponents;
  String? moreInformation;
  bool isArea;
  List<DeficiencyAreaItem>? deficiencyAreaItems;
  List<DeficiencyInspectionsReqModel>? deficiencyInspectionsReqModel = [];

  DeficiencyArea({
    this.id,
    this.name,
    this.definition,
    this.purpose,
    this.commonComponents,
    this.isArea = false,
    this.moreInformation,
    this.deficiencyAreaItems,
    this.deficiencyInspectionsReqModel,
  });

  factory DeficiencyArea.fromJson(Map<String, dynamic> json) => DeficiencyArea(
        id: json["id"],
        name: json["name"],
        definition: json["definition"],
        purpose: json["purpose"],
        commonComponents: json["common_components"],
        moreInformation: json["more_information"],
        deficiencyAreaItems: json["deficiency_area_items"] == null
            ? []
            : List<DeficiencyAreaItem>.from(json["deficiency_area_items"]!
                .map((x) => DeficiencyAreaItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "definition": definition,
        "purpose": purpose,
        "common_components": commonComponents,
        "more_information": moreInformation,
        "deficiency_area_items": deficiencyAreaItems == null
            ? []
            : List<dynamic>.from(deficiencyAreaItems!.map((x) => x.toJson())),
      };
}

class DeficiencyAreaItem {
  int? id;
  String? description;
  dynamic note;
  String? criteria;
  String? observation;
  String? action;
  String? moreInformation;
  String? requestForHelp;
  bool? status;
  List<DeficiencyItemHousingDeficiency>? deficiencyItemHousingDeficiency;

  DeficiencyAreaItem({
    this.id,
    this.description,
    this.note,
    this.criteria,
    this.observation,
    this.action,
    this.moreInformation,
    this.status,
    this.requestForHelp,
    this.deficiencyItemHousingDeficiency,
  });

  factory DeficiencyAreaItem.fromJson(Map<String, dynamic> json) =>
      DeficiencyAreaItem(
        id: json["id"],
        description: json["description"],
        note: json["note"],
        criteria: json["criteria"],
        observation: json["observation"],
        action: json["action"],
        moreInformation: json["more_information"],
        requestForHelp: json["request_for_help"],
        deficiencyItemHousingDeficiency:
            json["deficiency_item_housing_deficiency"] == null
                ? []
                : List<DeficiencyItemHousingDeficiency>.from(
                    json["deficiency_item_housing_deficiency"]!.map(
                        (x) => DeficiencyItemHousingDeficiency.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "note": note,
        "criteria": criteria,
        "observation": observation,
        "action": action,
        "more_information": moreInformation,
        "request_for_help": requestForHelp,
        "deficiency_item_housing_deficiency":
            deficiencyItemHousingDeficiency == null
                ? []
                : List<dynamic>.from(
                    deficiencyItemHousingDeficiency!.map((x) => x.toJson())),
      };
}

class DeficiencyItemHousingDeficiency {
  int? id;
  Severity? severity;
  HousingItem? housingItem;

  DeficiencyItemHousingDeficiency({
    this.id,
    this.severity,
    this.housingItem,
  });

  factory DeficiencyItemHousingDeficiency.fromJson(Map<String, dynamic> json) =>
      DeficiencyItemHousingDeficiency(
        id: json["id"],
        severity: json["severity"] == null
            ? null
            : Severity.fromJson(json["severity"]),
        housingItem: json["housing_item"] == null
            ? null
            : HousingItem.fromJson(json["housing_item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "severity": severity?.toJson(),
        "housing_item": housingItem?.toJson(),
      };
}

class HousingItem {
  int? id;
  String? item;
  dynamic description;

  HousingItem({
    this.id,
    this.item,
    this.description,
  });

  factory HousingItem.fromJson(Map<String, dynamic> json) => HousingItem(
        id: json["id"],
        item: json["item"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": item,
        "description": description,
      };
}

class Severity {
  int? id;
  String? healthySafetyDesignation;
  String? correctionTimeFrame;

  Severity({
    this.id,
    this.healthySafetyDesignation,
    this.correctionTimeFrame,
  });

  factory Severity.fromJson(Map<String, dynamic> json) => Severity(
        id: json["id"],
        healthySafetyDesignation: json["healthy_safety_designation"],
        correctionTimeFrame: json["correction_time_frame"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "healthy_safety_designation": healthySafetyDesignation,
        "correction_time_frame": correctionTimeFrame,
      };
}

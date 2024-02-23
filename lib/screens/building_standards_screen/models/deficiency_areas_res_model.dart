// To parse this JSON data, do
//
//     final deficiencyAreasResponseModel = deficiencyAreasResponseModelFromJson(jsonString);

import 'dart:convert';

DeficiencyAreasResponseModel deficiencyAreasResponseModelFromJson(String str) => DeficiencyAreasResponseModel.fromJson(json.decode(str));

String deficiencyAreasResponseModelToJson(DeficiencyAreasResponseModel data) => json.encode(data.toJson());

class DeficiencyAreasResponseModel {
  String? type;
  List<DeficiencyArea>? deficiencyAreas;

  DeficiencyAreasResponseModel({
    this.type,
    this.deficiencyAreas,
  });

  factory DeficiencyAreasResponseModel.fromJson(Map<String, dynamic> json) => DeficiencyAreasResponseModel(
    type: json["type"],
    deficiencyAreas: json["deficiency_areas"] == null ? [] : List<DeficiencyArea>.from(json["deficiency_areas"]!.map((x) => DeficiencyArea.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "deficiency_areas": deficiencyAreas == null ? [] : List<dynamic>.from(deficiencyAreas!.map((x) => x.toJson())),
  };
}

class DeficiencyArea {
  int? id;
  String? name;
  String? definition;
  String? purpose;
  String? commonComponents;
  String? moreInformation;
  List<DeficiencyAreaItem>? deficiencyAreaItems;

  DeficiencyArea({
    this.id,
    this.name,
    this.definition,
    this.purpose,
    this.commonComponents,
    this.moreInformation,
    this.deficiencyAreaItems,
  });

  factory DeficiencyArea.fromJson(Map<String, dynamic> json) => DeficiencyArea(
    id: json["id"],
    name: json["name"],
    definition: json["definition"],
    purpose: json["purpose"],
    commonComponents: json["common_components"],
    moreInformation: json["more_information"],
    deficiencyAreaItems: json["deficiency_area_items"] == null ? [] : List<DeficiencyAreaItem>.from(json["deficiency_area_items"]!.map((x) => DeficiencyAreaItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "definition": definition,
    "purpose": purpose,
    "common_components": commonComponents,
    "more_information": moreInformation,
    "deficiency_area_items": deficiencyAreaItems == null ? [] : List<dynamic>.from(deficiencyAreaItems!.map((x) => x.toJson())),
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
  List<DeficiencyItemHousingDeficiency>? deficiencyItemHousingDeficiency;

  DeficiencyAreaItem({
    this.id,
    this.description,
    this.note,
    this.criteria,
    this.observation,
    this.action,
    this.moreInformation,
    this.requestForHelp,
    this.deficiencyItemHousingDeficiency,
  });

  factory DeficiencyAreaItem.fromJson(Map<String, dynamic> json) => DeficiencyAreaItem(
    id: json["id"],
    description: json["description"],
    note: json["note"],
    criteria: json["criteria"],
    observation: json["observation"],
    action: json["action"],
    moreInformation: json["more_information"],
    requestForHelp: json["request_for_help"],
    deficiencyItemHousingDeficiency: json["deficiency_item_housing_deficiency"] == null ? [] : List<DeficiencyItemHousingDeficiency>.from(json["deficiency_item_housing_deficiency"]!.map((x) => DeficiencyItemHousingDeficiency.fromJson(x))),
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
    "deficiency_item_housing_deficiency": deficiencyItemHousingDeficiency == null ? [] : List<dynamic>.from(deficiencyItemHousingDeficiency!.map((x) => x.toJson())),
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

  factory DeficiencyItemHousingDeficiency.fromJson(Map<String, dynamic> json) => DeficiencyItemHousingDeficiency(
    id: json["id"],
    severity: json["severity"] == null ? null : Severity.fromJson(json["severity"]),
    housingItem: json["housing_item"] == null ? null : HousingItem.fromJson(json["housing_item"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "severity": severity?.toJson(),
    "housing_item": housingItem?.toJson(),
  };
}

class HousingItem {
  int? id;
  Item? item;
  dynamic description;

  HousingItem({
    this.id,
    this.item,
    this.description,
  });

  factory HousingItem.fromJson(Map<String, dynamic> json) => HousingItem(
    id: json["id"],
    item: itemValues.map[json["item"]]!,
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item": itemValues.reverse[item],
    "description": description,
  };
}

enum Item {
  BUILDING_INSIDE,
  PROPERTY_OUTSIDE,
  UNIT
}

final itemValues = EnumValues({
  "Building - Inside": Item.BUILDING_INSIDE,
  "Property - Outside": Item.PROPERTY_OUTSIDE,
  "Unit": Item.UNIT
});

class Severity {
  int? id;
  HealthySafetyDesignation? healthySafetyDesignation;
  CorrectionTimeFrame? correctionTimeFrame;

  Severity({
    this.id,
    this.healthySafetyDesignation,
    this.correctionTimeFrame,
  });

  factory Severity.fromJson(Map<String, dynamic> json) => Severity(
    id: json["id"],
    healthySafetyDesignation: healthySafetyDesignationValues.map[json["healthy_safety_designation"]]!,
    correctionTimeFrame: correctionTimeFrameValues.map[json["correction_time_frame"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "healthy_safety_designation": healthySafetyDesignationValues.reverse[healthySafetyDesignation],
    "correction_time_frame": correctionTimeFrameValues.reverse[correctionTimeFrame],
  };
}

enum CorrectionTimeFrame {
  N_A_PASS,
  THE_24_HOURS,
  THE_30_DAYS
}

final correctionTimeFrameValues = EnumValues({
  "(N/A) Pass": CorrectionTimeFrame.N_A_PASS,
  "24 Hours": CorrectionTimeFrame.THE_24_HOURS,
  "30 Days": CorrectionTimeFrame.THE_30_DAYS
});

enum HealthySafetyDesignation {
  L,
  LT,
  M,
  S
}

final healthySafetyDesignationValues = EnumValues({
  "L": HealthySafetyDesignation.L,
  "LT": HealthySafetyDesignation.LT,
  "M": HealthySafetyDesignation.M,
  "S": HealthySafetyDesignation.S
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

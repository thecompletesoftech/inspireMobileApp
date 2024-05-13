// To parse this JSON data, do
//
//     final getBuildingTypeResponseModel = getBuildingTypeResponseModelFromJson(jsonString);

import 'dart:convert';

GetBuildingTypeResponseModel getBuildingTypeResponseModelFromJson(String str) =>
    GetBuildingTypeResponseModel.fromJson(json.decode(str));

String getBuildingTypeResponseModelToJson(GetBuildingTypeResponseModel data) =>
    json.encode(data.toJson());

class GetBuildingTypeResponseModel {
  String? type;
  List<BuildingType>? buildingTypes;

  GetBuildingTypeResponseModel({
    this.type,
    this.buildingTypes,
  });

  factory GetBuildingTypeResponseModel.fromJson(Map<String, dynamic> json) =>
      GetBuildingTypeResponseModel(
        type: json["type"],
        buildingTypes: json["building_types"] == null
            ? []
            : List<BuildingType>.from(
                json["building_types"]!.map((x) => BuildingType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "building_types": buildingTypes == null
            ? []
            : List<dynamic>.from(buildingTypes!.map((x) => x.toJson())),
      };
}

class BuildingType {
  int? id;
  String? name;
  dynamic description;

  BuildingType({
    this.id,
    this.name,
    this.description,
  });

  factory BuildingType.fromJson(Map<String, dynamic> json) => BuildingType(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

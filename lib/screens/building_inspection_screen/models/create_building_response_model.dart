// To parse this JSON data, do
//
//     final createBuildingResponseModel = createBuildingResponseModelFromJson(jsonString);

import 'dart:convert';

CreateBuildingResponseModel createBuildingResponseModelFromJson(String str) =>
    CreateBuildingResponseModel.fromJson(json.decode(str));

String createBuildingResponseModelToJson(CreateBuildingResponseModel data) =>
    json.encode(data.toJson());

class CreateBuildingResponseModel {
  String? type;
  Building? building;

  CreateBuildingResponseModel({
    this.type,
    this.building,
  });

  factory CreateBuildingResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateBuildingResponseModel(
        type: json["type"],
        building: json["building"] == null
            ? null
            : Building.fromJson(json["building"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "building": building?.toJson(),
      };
}

class Building {
  int? id;
  String? address1;
  dynamic address2;
  String? city;
  String? state;
  String? zip;
  String? name;
  dynamic number;
  Property? property;
  int? constructedYear;
  BuildingType? buildingType;

  Building({
    this.id,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zip,
    this.name,
    this.number,
    this.property,
    this.constructedYear,
    this.buildingType,
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        id: json["id"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        name: json["name"],
        number: json["number"],
        property: json["property"] == null
            ? null
            : Property.fromJson(json["property"]),
        constructedYear: json["constructed_year"],
        buildingType: json["building_type"] == null
            ? null
            : BuildingType.fromJson(json["building_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "zip": zip,
        "name": name,
        "number": number,
        "property": property?.toJson(),
        "constructed_year": constructedYear,
        "building_type": buildingType?.toJson(),
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

class Property {
  int? id;
  String? address1;

  Property({
    this.id,
    this.address1,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        address1: json["address1"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address1": address1,
      };
}

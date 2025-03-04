// To parse this JSON data, do
//
//     final buildingModel = buildingModelFromJson(jsonString);

import 'dart:convert';

BuildingModel buildingModelFromJson(String str) =>
    BuildingModel.fromJson(json.decode(str));

String buildingModelToJson(BuildingModel data) => json.encode(data.toJson());

class BuildingModel {
  String? type;
  List<Building>? buildings;

  BuildingModel({this.type, this.buildings});

  factory BuildingModel.fromJson(Map<String, dynamic> json) => BuildingModel(
        type: json["type"],
        buildings: json["buildings"] == null
            ? []
            : List<Building>.from(
                json["buildings"]!.map((x) => Building.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "buildings": buildings == null
            ? []
            : List<dynamic>.from(buildings!.map((x) => x.toJson())),
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
  dynamic constructedYear;
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

  BuildingType({this.id, this.name, this.description});

  factory BuildingType.fromJson(Map<String, dynamic> json) => BuildingType(
      id: json["id"], name: json["name"], description: json["description"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "description": description};
}

class Property {
  int? id;
  dynamic address1;

  Property({this.id, this.address1});

  factory Property.fromJson(Map<String, dynamic> json) =>
      Property(id: json["id"], address1: json["address1"]);

  Map<String, dynamic> toJson() => {"id": id, "address1": address1};
}

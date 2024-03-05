// To parse this JSON data, do
//
//     final createBuildingRequestModel = createBuildingRequestModelFromJson(jsonString);

import 'dart:convert';

CreateBuildingRequestModel createBuildingRequestModelFromJson(String str) =>
    CreateBuildingRequestModel.fromJson(json.decode(str));

String createBuildingRequestModelToJson(CreateBuildingRequestModel data) =>
    json.encode(data.toJson());

class CreateBuildingRequestModel {
  String? name;
  String? constructedYear;
  String? buildingTypeId;
  String? city;
  String? state;
  String? zip;
  String? address1;
  int? propertyId;

  CreateBuildingRequestModel({
    this.name,
    this.constructedYear,
    this.buildingTypeId,
    this.city,
    this.state,
    this.zip,
    this.address1,
    this.propertyId,
  });

  factory CreateBuildingRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateBuildingRequestModel(
        name: json["name"],
        constructedYear: json["constructed_year"],
        buildingTypeId: json["building_type_id"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        address1: json["address1"],
        propertyId: json["property_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "constructed_year": constructedYear,
        "building_type_id": buildingTypeId,
        "city": city,
        "state": state,
        "zip": zip,
        "address1": address1,
        "property_id": propertyId,
      };
}

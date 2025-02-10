// To parse this JSON data, do
//
//     final createInspectionModel = createInspectionModelFromJson(jsonString);

import 'dart:convert';

import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';

CreateInspectionModel createInspectionModelFromJson(String str) =>
    CreateInspectionModel.fromJson(json.decode(str));

String createInspectionModelToJson(CreateInspectionModel data) =>
    json.encode(data.toJson());

class CreateInspectionModel {
  String? type;
  Inspection? inspection;

  CreateInspectionModel({this.type, this.inspection});

  factory CreateInspectionModel.fromJson(Map<String, dynamic> json) =>
      CreateInspectionModel(
        type: json["type"],
        inspection: json["inspection"] == null
            ? null
            : Inspection.fromJson(json["inspection"]),
      );

  Map<String, dynamic> toJson() =>
      {"type": type, "inspection": inspection?.toJson()};
}

class Inspection {
  int? id;
  String? comment;
  String? date;
  bool? occupied;
  Inspector? inspector;
  InspectionType? inspectionType;
  InspectionState? inspectionState;
  ExternalPropertyClass? externalProperty;
  Building? externalBuilding;
  ExternalUnit? externalUnit;
  List<InspectionDeficiencyInspection>? inspectionDeficiencyInspection;
  List<dynamic>? inspectionBuildingCertificate;
  String? generalPhysicalCondition;
  String? unitHouseKeeping;
  dynamic memo;

  Inspection({
    this.id,
    this.comment,
    this.date,
    this.occupied,
    this.inspector,
    this.inspectionType,
    this.inspectionState,
    this.externalProperty,
    this.externalBuilding,
    this.externalUnit,
    this.inspectionDeficiencyInspection,
    this.inspectionBuildingCertificate,
    this.generalPhysicalCondition,
    this.unitHouseKeeping,
    this.memo,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) => Inspection(
        id: json["id"],
        comment: json["comment"],
        date: json["date"],
        occupied: json["occupied"],
        inspector: json["inspector"] == null
            ? null
            : Inspector.fromJson(json["inspector"]),
        inspectionType: json["inspection_type"] == null
            ? null
            : InspectionType.fromJson(json["inspection_type"]),
        inspectionState: json["inspection_state"] == null
            ? null
            : InspectionState.fromJson(json["inspection_state"]),
        externalProperty: json["external_property"] == null
            ? null
            : ExternalPropertyClass.fromJson(json["external_property"]),
        externalBuilding: json["external_building"] == null
            ? null
            : Building.fromJson(json["external_building"]),
        externalUnit: json["external_unit"] == null
            ? null
            : ExternalUnit.fromJson(json["external_unit"]),
        inspectionDeficiencyInspection:
            json["inspection_deficiency_inspection"] == null
                ? []
                : List<InspectionDeficiencyInspection>.from(
                    json["inspection_deficiency_inspection"]!.map(
                        (x) => InspectionDeficiencyInspection.fromJson(x))),
        inspectionBuildingCertificate:
            json["inspection_building_certificate"] == null
                ? []
                : List<dynamic>.from(
                    json["inspection_building_certificate"]!.map((x) => x)),
        generalPhysicalCondition: json["general_physical_condition"],
        unitHouseKeeping: json["unit_house_keeping"],
        memo: json["memo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "date": date,
        "occupied": occupied,
        "inspector": inspector?.toJson(),
        "inspection_type": inspectionType?.toJson(),
        "inspection_state": inspectionState?.toJson(),
        "external_property": externalProperty?.toJson(),
        "external_building": externalBuilding?.toJson(),
        "external_unit": externalUnit?.toJson(),
        "inspection_deficiency_inspection":
            inspectionDeficiencyInspection == null
                ? []
                : List<dynamic>.from(
                    inspectionDeficiencyInspection!.map((x) => x.toJson())),
        "inspection_building_certificate": inspectionBuildingCertificate == null
            ? []
            : List<dynamic>.from(inspectionBuildingCertificate!.map((x) => x)),
        "general_physical_condition": generalPhysicalCondition,
        "unit_house_keeping": unitHouseKeeping,
        "memo": memo,
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
  String? number;
  ExternalBuildingProperty? property;
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
            : ExternalBuildingProperty.fromJson(json["property"]),
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

class ExternalBuildingProperty {
  int? id;
  String? address1;

  ExternalBuildingProperty({this.id, this.address1});

  factory ExternalBuildingProperty.fromJson(Map<String, dynamic> json) =>
      ExternalBuildingProperty(id: json["id"], address1: json["address1"]);

  Map<String, dynamic> toJson() => {"id": id, "address1": address1};
}

class ExternalPropertyClass {
  int? id;
  String? address1;
  dynamic address2;
  String? city;
  String? state;
  String? zip;
  String? name;
  String? number;
  dynamic ampNumber;
  String? notes;

  ExternalPropertyClass({
    this.id,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zip,
    this.name,
    this.number,
    this.ampNumber,
    this.notes,
  });

  factory ExternalPropertyClass.fromJson(Map<String, dynamic> json) =>
      ExternalPropertyClass(
        id: json["id"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        name: json["name"],
        number: json["number"],
        ampNumber: json["amp_number"],
        notes: json["notes"],
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
        "amp_number": ampNumber,
        "notes": notes,
      };
}

class ExternalUnit {
  int? id;
  String? name;
  String? address;
  int? numberOfBedrooms;
  int? numberOfBathrooms;
  bool? occupied;
  ExternalPropertyClass? property;
  Building? building;

  ExternalUnit({
    this.id,
    this.name,
    this.address,
    this.numberOfBedrooms,
    this.numberOfBathrooms,
    this.occupied,
    this.property,
    this.building,
  });

  factory ExternalUnit.fromJson(Map<String, dynamic> json) => ExternalUnit(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        numberOfBedrooms: json["number_of_bedrooms"],
        numberOfBathrooms: json["number_of_bathrooms"],
        occupied: json["occupied"],
        property: json["property"] == null
            ? null
            : ExternalPropertyClass.fromJson(json["property"]),
        building: json["building"] == null
            ? null
            : Building.fromJson(json["building"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "number_of_bedrooms": numberOfBedrooms,
        "number_of_bathrooms": numberOfBathrooms,
        "occupied": occupied,
        "property": property?.toJson(),
        "building": building?.toJson(),
      };
}

class InspectionDeficiencyInspection {
  String? comment;
  HousingDeficiency? housingDeficiency;
  List<DeficiencyInspectionDeficiencyProofPicture>?
      deficiencyInspectionDeficiencyProofPicture;

  InspectionDeficiencyInspection({
    this.comment,
    this.housingDeficiency,
    this.deficiencyInspectionDeficiencyProofPicture,
  });

  factory InspectionDeficiencyInspection.fromJson(Map<String, dynamic> json) =>
      InspectionDeficiencyInspection(
        comment: json["comment"],
        housingDeficiency: json["housing_deficiency"] == null
            ? null
            : HousingDeficiency.fromJson(json["housing_deficiency"]),
        deficiencyInspectionDeficiencyProofPicture:
            json["deficiency_inspection_deficiency_proof_picture"] == null
                ? []
                : List<DeficiencyInspectionDeficiencyProofPicture>.from(
                    json["deficiency_inspection_deficiency_proof_picture"]!.map(
                        (x) =>
                            DeficiencyInspectionDeficiencyProofPicture.fromJson(
                                x))),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "housing_deficiency": housingDeficiency?.toJson(),
        "deficiency_inspection_deficiency_proof_picture":
            deficiencyInspectionDeficiencyProofPicture == null
                ? []
                : List<dynamic>.from(deficiencyInspectionDeficiencyProofPicture!
                    .map((x) => x.toJson())),
      };
}

class DeficiencyInspectionDeficiencyProofPicture {
  String? picture;
  dynamic description;

  DeficiencyInspectionDeficiencyProofPicture({this.picture, this.description});

  factory DeficiencyInspectionDeficiencyProofPicture.fromJson(
          Map<String, dynamic> json) =>
      DeficiencyInspectionDeficiencyProofPicture(
          picture: json["picture"], description: json["description"]);

  Map<String, dynamic> toJson() =>
      {"picture": picture, "description": description};
}

class HousingDeficiency {
  int? id;
  Severity? severity;
  HousingItem? housingItem;
  dynamic correctionTimeFrame;

  HousingDeficiency(
      {this.id, this.severity, this.housingItem, this.correctionTimeFrame});

  factory HousingDeficiency.fromJson(Map<String, dynamic> json) =>
      HousingDeficiency(
        id: json["id"],
        severity: json["severity"] == null
            ? null
            : Severity.fromJson(json["severity"]),
        housingItem: json["housing_item"] == null
            ? null
            : HousingItem.fromJson(json["housing_item"]),
        correctionTimeFrame: json["correction_time_frame"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "severity": severity?.toJson(),
        "housing_item": housingItem?.toJson(),
        "correction_time_frame": correctionTimeFrame,
      };
}

class HousingItem {
  int? id;
  String? item;
  dynamic description;

  HousingItem({this.id, this.item, this.description});

  factory HousingItem.fromJson(Map<String, dynamic> json) => HousingItem(
      id: json["id"], item: json["item"], description: json["description"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "item": item, "description": description};
}

class Severity {
  int? id;
  String? healthySafetyDesignation;

  Severity({this.id, this.healthySafetyDesignation});

  factory Severity.fromJson(Map<String, dynamic> json) => Severity(
        id: json["id"],
        healthySafetyDesignation: json["healthy_safety_designation"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "healthy_safety_designation": healthySafetyDesignation};
}

class InspectionState {
  int? id;
  String? state;
  dynamic description;

  InspectionState({this.id, this.state, this.description});

  factory InspectionState.fromJson(Map<String, dynamic> json) =>
      InspectionState(
        id: json["id"],
        state: json["state"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "state": state, "description": description};
}

// To parse this JSON data, do
//
//     final createinspectionModel = createinspectionModelFromJson(jsonString);

import 'dart:convert';

CreateinspectionModel createinspectionModelFromJson(String str) =>
    CreateinspectionModel.fromJson(json.decode(str));

String createinspectionModelToJson(CreateinspectionModel data) =>
    json.encode(data.toJson());

class CreateinspectionModel {
  String type;
  Inspection inspection;

  CreateinspectionModel({
    required this.type,
    required this.inspection,
  });

  factory CreateinspectionModel.fromJson(Map<String, dynamic> json) =>
      CreateinspectionModel(
        type: json["type"],
        inspection: Inspection.fromJson(json["inspection"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "inspection": inspection.toJson(),
      };
}

class Inspection {
  int id;
  String comment;
  DateTime date;
  bool occupied;
  Inspector inspector;
  InspectionType inspectionType;
  InspectionState inspectionState;
  ExternalPropertyClass externalProperty;
  Building externalBuilding;
  ExternalUnit externalUnit;
  List<InspectionDeficiencyInspection> inspectionDeficiencyInspection;
  List<InspectionBuildingCertificate> inspectionBuildingCertificate;

  Inspection({
    required this.id,
    required this.comment,
    required this.date,
    required this.occupied,
    required this.inspector,
    required this.inspectionType,
    required this.inspectionState,
    required this.externalProperty,
    required this.externalBuilding,
    required this.externalUnit,
    required this.inspectionDeficiencyInspection,
    required this.inspectionBuildingCertificate,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) => Inspection(
        id: json["id"],
        comment: json["comment"],
        date: DateTime.parse(json["date"]),
        occupied: json["occupied"],
        inspector: Inspector.fromJson(json["inspector"]),
        inspectionType: InspectionType.fromJson(json["inspection_type"]),
        inspectionState: InspectionState.fromJson(json["inspection_state"]),
        externalProperty:
            ExternalPropertyClass.fromJson(json["external_property"]),
        externalBuilding: Building.fromJson(json["external_building"]),
        externalUnit: ExternalUnit.fromJson(json["external_unit"]),
        inspectionDeficiencyInspection:
            List<InspectionDeficiencyInspection>.from(
                json["inspection_deficiency_inspection"]
                    .map((x) => InspectionDeficiencyInspection.fromJson(x))),
        inspectionBuildingCertificate: List<InspectionBuildingCertificate>.from(
            json["inspection_building_certificate"]
                .map((x) => InspectionBuildingCertificate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "date": date.toIso8601String(),
        "occupied": occupied,
        "inspector": inspector.toJson(),
        "inspection_type": inspectionType.toJson(),
        "inspection_state": inspectionState.toJson(),
        "external_property": externalProperty.toJson(),
        "external_building": externalBuilding.toJson(),
        "external_unit": externalUnit.toJson(),
        "inspection_deficiency_inspection": List<dynamic>.from(
            inspectionDeficiencyInspection.map((x) => x.toJson())),
        "inspection_building_certificate": List<dynamic>.from(
            inspectionBuildingCertificate.map((x) => x.toJson())),
      };
}

class Building {
  String id;
  String address1;
  dynamic address2;
  String city;
  String state;
  String zip;
  String name;
  dynamic number;
  ExternalBuildingProperty property;
  String constructedYear;
  BuildingType buildingType;

  Building({
    required this.id,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.zip,
    required this.name,
    required this.number,
    required this.property,
    required this.constructedYear,
    required this.buildingType,
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        id: json["id"].toString(),
        address1: json["address1"].toString(),
        address2: json["address2"].toString(),
        city: json["city"].toString(),
        state: json["state"].toString(),
        zip: json["zip"].toString(),
        name: json["name"].toString(),
        number: json["number"].toString(),
        property: json["property"] == null
            ? ExternalBuildingProperty.fromJson({})
            : ExternalBuildingProperty.fromJson(json["property"]),
        constructedYear: json["constructed_year"].toString(),
        buildingType: json["building_type"] == null
            ? BuildingType.fromJson({})
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
        "property": property.toJson(),
        "constructed_year": constructedYear,
        "building_type": buildingType.toJson(),
      };
}

class BuildingType {
  String id;
  String name;
  dynamic description;

  BuildingType({
    required this.id,
    required this.name,
    required this.description,
  });

  factory BuildingType.fromJson(Map<String, dynamic> json) => BuildingType(
        id: json["id"].toString(),
        name: json["name"].toString(),
        description: json["description"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "name": name.toString(),
        "description": description.toString(),
      };
}

class ExternalBuildingProperty {
  String id;
  String address1;

  ExternalBuildingProperty({
    required this.id,
    required this.address1,
  });

  factory ExternalBuildingProperty.fromJson(Map<String, dynamic> json) =>
      ExternalBuildingProperty(
        id: json["id"].toString(),
        address1: json["address1"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address1": address1,
      };
}

class ExternalPropertyClass {
  String id;
  String address1;
  dynamic address2;
  String city;
  String state;
  String zip;
  String name;
  dynamic number;
  dynamic ampNumber;
  dynamic notes;

  ExternalPropertyClass({
    required this.id,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.zip,
    required this.name,
    required this.number,
    required this.ampNumber,
    required this.notes,
  });

  factory ExternalPropertyClass.fromJson(Map<String, dynamic> json) =>
      ExternalPropertyClass(
          id: json["id"].toString(),
          address1: json["address1"].toString(),
          address2: json["address2"].toString(),
          city: json["city"].toString(),
          state: json["state"].toString(),
          zip: json["zip"].toString(),
          name: json["name"].toString(),
          number: json["number"].toString(),
          ampNumber: json["amp_number"].toString(),
          notes: json["notes"].toString());

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
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
  String id;
  String name;
  String address;
  String numberOfBedrooms;
  String numberOfBathrooms;
  ExternalPropertyClass property;
  Building building;

  ExternalUnit({
    required this.id,
    required this.name,
    required this.address,
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.property,
    required this.building,
  });

  factory ExternalUnit.fromJson(Map<String, dynamic> json) => ExternalUnit(
        id: json["id"].toString(),
        name: json["name"],
        address: json["address"],
        numberOfBedrooms: json["number_of_bedrooms"].toString(),
        numberOfBathrooms: json["number_of_bathrooms"].toString(),
        property: json["property"] == null
            ? ExternalPropertyClass.fromJson({})
            : ExternalPropertyClass.fromJson(json["property"]),
        building: json["building"] == null
            ? Building.fromJson({})
            : Building.fromJson(json["building"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "name": name,
        "address": address,
        "number_of_bedrooms": numberOfBedrooms,
        "number_of_bathrooms": numberOfBathrooms,
        "property": property.toJson(),
        "building": building.toJson(),
      };
}

class InspectionBuildingCertificate {
  Certificate certificate;

  InspectionBuildingCertificate({
    required this.certificate,
  });

  factory InspectionBuildingCertificate.fromJson(Map<String, dynamic> json) =>
      InspectionBuildingCertificate(
        certificate: Certificate.fromJson(json["certificate"]),
      );

  Map<String, dynamic> toJson() => {
        "certificate": certificate.toJson(),
      };
}

class Certificate {
  int id;
  String certificate;

  Certificate({
    required this.id,
    required this.certificate,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["id"],
        certificate: json["certificate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "certificate": certificate,
      };
}

class InspectionDeficiencyInspection {
  String comment;
  HousingDeficiency housingDeficiency;
  List<DeficiencyInspectionDeficiencyProofPicture>
      deficiencyInspectionDeficiencyProofPicture;

  InspectionDeficiencyInspection({
    required this.comment,
    required this.housingDeficiency,
    required this.deficiencyInspectionDeficiencyProofPicture,
  });

  factory InspectionDeficiencyInspection.fromJson(Map<String, dynamic> json) =>
      InspectionDeficiencyInspection(
        comment: json["comment"],
        housingDeficiency:
            HousingDeficiency.fromJson(json["housing_deficiency"]),
        deficiencyInspectionDeficiencyProofPicture:
            List<DeficiencyInspectionDeficiencyProofPicture>.from(json[
                    "deficiency_inspection_deficiency_proof_picture"]
                .map((x) =>
                    DeficiencyInspectionDeficiencyProofPicture.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "housing_deficiency": housingDeficiency.toJson(),
        "deficiency_inspection_deficiency_proof_picture": List<dynamic>.from(
            deficiencyInspectionDeficiencyProofPicture.map((x) => x.toJson())),
      };
}

class DeficiencyInspectionDeficiencyProofPicture {
  String picture;
  dynamic description;

  DeficiencyInspectionDeficiencyProofPicture({
    required this.picture,
    required this.description,
  });

  factory DeficiencyInspectionDeficiencyProofPicture.fromJson(
          Map<String, dynamic> json) =>
      DeficiencyInspectionDeficiencyProofPicture(
        picture: json["picture"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "picture": picture,
        "description": description,
      };
}

class HousingDeficiency {
  int id;
  Severity severity;
  HousingItem housingItem;

  HousingDeficiency({
    required this.id,
    required this.severity,
    required this.housingItem,
  });

  factory HousingDeficiency.fromJson(Map<String, dynamic> json) =>
      HousingDeficiency(
        id: json["id"],
        severity: Severity.fromJson(json["severity"]),
        housingItem: HousingItem.fromJson(json["housing_item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "severity": severity.toJson(),
        "housing_item": housingItem.toJson(),
      };
}

class HousingItem {
  int id;
  String item;
  dynamic description;

  HousingItem({
    required this.id,
    required this.item,
    required this.description,
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
  int id;
  String healthySafetyDesignation;
  String correctionTimeFrame;

  Severity({
    required this.id,
    required this.healthySafetyDesignation,
    required this.correctionTimeFrame,
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

class InspectionState {
  int id;
  String state;
  dynamic description;

  InspectionState({
    required this.id,
    required this.state,
    required this.description,
  });

  factory InspectionState.fromJson(Map<String, dynamic> json) =>
      InspectionState(
        id: json["id"],
        state: json["state"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "description": description,
      };
}

class InspectionType {
  int id;
  String type;
  dynamic description;

  InspectionType({
    required this.id,
    required this.type,
    required this.description,
  });

  factory InspectionType.fromJson(Map<String, dynamic> json) => InspectionType(
        id: json["id"],
        type: json["type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "description": description,
      };
}

class Inspector {
  int id;
  String externalAccountId;
  String externalPersonalId;

  Inspector({
    required this.id,
    required this.externalAccountId,
    required this.externalPersonalId,
  });

  factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
        id: json["id"],
        externalAccountId: json["external_account_id"].toString(),
        externalPersonalId: json["external_personal_id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "external_account_id": externalAccountId.toString(),
        "external_personal_id": externalPersonalId.toString(),
      };
}

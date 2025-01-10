// To parse this JSON data, do
//
//     final createInspectionRequestModel = createInspectionRequestModelFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

CreateInspectionRequestModel createInspectionRequestModelFromJson(String str) =>
    CreateInspectionRequestModel.fromJson(json.decode(str));

String createInspectionRequestModelToJson(CreateInspectionRequestModel data) =>
    json.encode(data.toJson());

class CreateInspectionRequestModel {
  Inspection? inspection;
  Property? property;
  Building? building;
  List<Certificate>? certificates;
  List<DeficiencyInspection>? deficiencyInspections;

  CreateInspectionRequestModel({
    this.inspection,
    this.property,
    this.building,
    this.certificates,
    this.deficiencyInspections,
  });

  factory CreateInspectionRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateInspectionRequestModel(
        inspection: json["inspection"] == null
            ? null
            : Inspection.fromJson(json["inspection"]),
        property: json["property"] == null
            ? null
            : Property.fromJson(json["property"]),
        building: json["building"] == null
            ? null
            : Building.fromJson(json["building"]),
        certificates: json["certificates"] == null
            ? []
            : List<Certificate>.from(
                json["certificates"]!.map((x) => Certificate.fromJson(x))),
        deficiencyInspections: json["deficiency_inspections"] == null
            ? []
            : List<DeficiencyInspection>.from(json["deficiency_inspections"]!
                .map((x) => DeficiencyInspection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "inspection": inspection?.toJson(),
        "property": property?.toJson(),
        "building": building?.toJson(),
        "certificates": certificates == null
            ? []
            : List<dynamic>.from(certificates!.map((x) => x.toJson())),
        "deficiency_inspections": deficiencyInspections == null
            ? []
            : List<dynamic>.from(deficiencyInspections!.map((x) => x.toJson())),
      };
}

class Building {
  String? id;
  String? name;
  String? constructedYear;
  String? buildingTypeId;

  Building({
    this.id,
    this.name,
    this.constructedYear,
    this.buildingTypeId,
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        id: json["id"],
        name: json["name"],
        constructedYear: json["constructed_year"],
        buildingTypeId: json["building_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "constructed_year": constructedYear,
        "building_type_id": buildingTypeId,
      };
}

class Certificate {
  String? id;

  Certificate({
    this.id,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class DeficiencyInspection {
  String? housingDeficiencyId;
  List<DeficiencyProofPicture>? deficiencyProofPictures;
  String? comment;
  String? date;

  DeficiencyInspection({
    this.housingDeficiencyId,
    this.deficiencyProofPictures,
    this.comment,
    this.date,
  });

  factory DeficiencyInspection.fromJson(Map<String, dynamic> json) =>
      DeficiencyInspection(
        housingDeficiencyId: json["housing_deficiency_id"],
        deficiencyProofPictures: json["deficiency_proof_pictures"] == null
            ? []
            : List<DeficiencyProofPicture>.from(
                json["deficiency_proof_pictures"]!
                    .map((x) => DeficiencyProofPicture.fromJson(x))),
        comment: json["comment"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "housing_deficiency_id": housingDeficiencyId,
        "deficiency_proof_pictures": deficiencyProofPictures == null
            ? []
            : List<dynamic>.from(
                deficiencyProofPictures!.map((x) => x.toJson())),
        "comment": comment,
        "date": date,
      };
}

class DeficiencyProofPicture {
  String? picturePath;

  DeficiencyProofPicture({
    this.picturePath,
  });

  factory DeficiencyProofPicture.fromJson(Map<String, dynamic> json) =>
      DeficiencyProofPicture(
        picturePath: json["picture_path"],
      );

  Map<String, dynamic> toJson() => {
        "picture_path": picturePath,
      };
}

class Inspection {
  String? inspectorId;
  dynamic? date;
  String? comment;
  String? inspectionStateId;
  String? inspectionTypeId;
  String? general_physical_condition;
  String? unit_house_keeping;

  Inspection({
    this.inspectorId,
    this.date,
    this.comment,
    this.inspectionStateId,
    this.inspectionTypeId,
    this.general_physical_condition,
    this.unit_house_keeping,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) => Inspection(
        inspectorId: json["inspector_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        comment: json["comment"],
        inspectionStateId: json["inspection_state_id"],
        inspectionTypeId: json["inspection_type_id"],
        general_physical_condition: json["general_physical_condition"],
        unit_house_keeping: json["unit_house_keeping"],
      );

  Map<String, dynamic> toJson() => {
        "inspector_id": inspectorId,
        "date": date,
        "comment": comment,
        "inspection_state_id": inspectionStateId,
        "inspection_type_id": inspectionTypeId,
        "unit_house_keeping": unit_house_keeping,
        "general_physical_condition": general_physical_condition,
      };
}

class Property {
  String? id;
  String? name;
  String? city;
  String? state;
  String? zip;
  String? address;

  Property({
    this.id,
    this.name,
    this.city,
    this.state,
    this.zip,
    this.address,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "state": state,
        "zip": zip,
        "address": address,
      };
}

// To parse this JSON data, do
//
//     final inspectionReqModel = inspectionReqModelFromJson(jsonString);

import 'dart:convert';

import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_req_model.dart';

InspectionReqModel inspectionReqModelFromJson(String str) =>
    InspectionReqModel.fromJson(json.decode(str));

String inspectionReqModelToJson(InspectionReqModel data) =>
    json.encode(data.toJson());

class InspectionReqModel {
  Inspection? inspection;
  Unit? unit;
  List<DeficiencyInspection>? deficiencyInspections;

  InspectionReqModel({
    this.inspection,
    this.unit,
    this.deficiencyInspections,
  });

  factory InspectionReqModel.fromJson(Map<String, dynamic> json) =>
      InspectionReqModel(
        inspection: json["inspection"] == null
            ? null
            : Inspection.fromJson(json["inspection"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        deficiencyInspections: json["deficiency_inspections"] == null
            ? []
            : List<DeficiencyInspection>.from(json["deficiency_inspections"]!
                .map((x) => DeficiencyInspection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "inspection": inspection?.toJson(),
        "unit": unit?.toJson(),
        "deficiency_inspections": deficiencyInspections == null
            ? []
            : List<dynamic>.from(deficiencyInspections!.map((x) => x.toJson())),
      };
}

class DeficiencyInspection {
  String? housingDeficiencyId;
  List<DeficiencyProofPicture>? deficiencyProofPictures;
  String? comment;

  DeficiencyInspection({
    this.housingDeficiencyId,
    this.deficiencyProofPictures,
    this.comment,
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
      );

  Map<String, dynamic> toJson() => {
        "housing_deficiency_id": housingDeficiencyId,
        "deficiency_proof_pictures": deficiencyProofPictures == null
            ? []
            : List<dynamic>.from(
                deficiencyProofPictures!.map((x) => x.toJson())),
        "comment": comment,
      };
}

class DeficiencyProofPicture {
  String? picturePath;
  String? comment;

  DeficiencyProofPicture({
    this.picturePath,
    this.comment,
  });

  factory DeficiencyProofPicture.fromJson(Map<String, dynamic> json) =>
      DeficiencyProofPicture(
        picturePath: json["picture_path"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "picture_path": picturePath,
        "comment": comment,
      };
}

class Inspection {
  String? inspectorId;
  DateTime? date;
  String? startTime;
  String? endTime;
  String? comment;
  String? inspectionStateId;
  String? inspectionTypeId;
  String? noShowImage;
  String? tenantSignature;
  String? landlordSignature;
  int? findingType;
  int? result;
  int? scheduleInspectionId;
  SpecialAmenities? specialAmenities;

  Inspection({
    this.inspectorId,
    this.date,
    this.startTime,
    this.endTime,
    this.comment,
    this.inspectionStateId,
    this.inspectionTypeId,
    this.noShowImage,
    this.tenantSignature,
    this.landlordSignature,
    this.findingType,
    this.result,
    this.scheduleInspectionId,
    this.specialAmenities,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) => Inspection(
        inspectorId: json["inspector_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        comment: json["comment"],
        inspectionStateId: json["inspection_state_id"],
        inspectionTypeId: json["inspection_type_id"],
        noShowImage: json["no_show_image"],
        tenantSignature: json["tenant_signature"],
        landlordSignature: json["landlord_signature"],
        findingType: json["finding_type"],
        result: json["result"],
        scheduleInspectionId: json["schedule_inspection_id"],
        specialAmenities: json["special_amenities"] == null
            ? null
            : SpecialAmenities.fromJson(json["special_amenities"]),
      );

  Map<String, dynamic> toJson() => {
        "inspector_id": inspectorId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "comment": comment,
        "inspection_state_id": inspectionStateId,
        "inspection_type_id": inspectionTypeId,
        "no_show_image": noShowImage,
        "tenant_signature": tenantSignature,
        "landlord_signature": landlordSignature,
        "finding_type": findingType,
        "result": result,
        "schedule_inspection_id": scheduleInspectionId,
        "special_amenities": specialAmenities?.toJson(),
      };
}

class Unit {
  int? id;
  String? name;
  String? address;
  int? numberOfBedrooms;
  int? numberOfBathrooms;
  bool? occupied;

  Unit({
    this.id,
    this.name,
    this.address,
    this.numberOfBedrooms,
    this.numberOfBathrooms,
    this.occupied,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        numberOfBedrooms: json["number_of_bedrooms"],
        numberOfBathrooms: json["number_of_bathrooms"],
        occupied: json["occupied"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "number_of_bedrooms": numberOfBedrooms,
        "number_of_bathrooms": numberOfBathrooms,
        "occupied": occupied,
      };
}

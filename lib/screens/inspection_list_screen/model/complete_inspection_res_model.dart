// To parse this JSON data, do
//
//     final completeInspectionResModel = completeInspectionResModelFromJson(jsonString);

import 'dart:convert';

import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_req_model.dart';
import 'package:public_housing/screens/unit_inspection_summary_screen/models/create_inspection_model.dart';

CompleteInspectionResModel completeInspectionResModelFromJson(String str) =>
    CompleteInspectionResModel.fromJson(json.decode(str));

String completeInspectionResModelToJson(CompleteInspectionResModel data) =>
    json.encode(data.toJson());

class CompleteInspectionResModel {
  String? type;
  List<CompleteInspection>? inspections;

  CompleteInspectionResModel({this.type, this.inspections});

  factory CompleteInspectionResModel.fromJson(Map<String, dynamic> json) =>
      CompleteInspectionResModel(
        type: json["type"],
        inspections: json["inspections"] == null
            ? []
            : List<CompleteInspection>.from(json["inspections"]!
                .map((x) => CompleteInspection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "inspections": inspections == null
            ? []
            : List<dynamic>.from(inspections!.map((x) => x.toJson())),
      };
}

class CompleteInspection {
  int? id;
  String? comment;
  DateTime? date;
  bool? occupied;
  Inspector? inspector;
  InspectionType? inspectionType;
  InspectionState? inspectionState;
  ExternalUnit? externalUnit;
  List<InspectionDeficiencyInspection>? inspectionDeficiencyInspection;
  FindingType? type;
  FindingType? findingType;
  FindingType? result;
  List<dynamic>? inspectionBuildingCertificate;
  dynamic generalPhysicalCondition;
  dynamic unitHouseKeeping;
  dynamic memo;
  dynamic generalNotes;
  SpecialAmenities? specialAmenities;
  String? noShowImage;
  String? tenantSignature;
  String? landlordSignature;
  String? startTime;
  String? endTime;

  CompleteInspection({
    this.id,
    this.comment,
    this.date,
    this.occupied,
    this.inspector,
    this.inspectionType,
    this.inspectionState,
    this.externalUnit,
    this.inspectionDeficiencyInspection,
    this.type,
    this.findingType,
    this.result,
    this.inspectionBuildingCertificate,
    this.generalPhysicalCondition,
    this.unitHouseKeeping,
    this.memo,
    this.generalNotes,
    this.specialAmenities,
    this.noShowImage,
    this.tenantSignature,
    this.landlordSignature,
    this.startTime,
    this.endTime,
  });

  factory CompleteInspection.fromJson(Map<String, dynamic> json) =>
      CompleteInspection(
        id: json["id"],
        comment: json["comment"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
        externalUnit: json["external_unit"] == null
            ? null
            : ExternalUnit.fromJson(json["external_unit"]),
        inspectionDeficiencyInspection:
            json["inspection_deficiency_inspection"] == null
                ? []
                : List<InspectionDeficiencyInspection>.from(
                    json["inspection_deficiency_inspection"]!.map(
                        (x) => InspectionDeficiencyInspection.fromJson(x))),
        type: json["type"] == null ? null : FindingType.fromJson(json["type"]),
        findingType: json["finding_type"] == null
            ? null
            : FindingType.fromJson(json["finding_type"]),
        result: json["result"] == null
            ? null
            : FindingType.fromJson(json["result"]),
        inspectionBuildingCertificate:
            json["inspection_building_certificate"] == null
                ? []
                : List<dynamic>.from(
                    json["inspection_building_certificate"]!.map((x) => x)),
        generalPhysicalCondition: json["general_physical_condition"],
        unitHouseKeeping: json["unit_house_keeping"],
        memo: json["memo"],
        generalNotes: json["general_notes"],
        specialAmenities: json["special_amenities"] == null
            ? null
            : SpecialAmenities.fromJson(json["special_amenities"]),
        noShowImage: json["no_show_image"],
        tenantSignature: json["tenant_signature"],
        landlordSignature: json["landlord_signature"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "date": date?.toIso8601String(),
        "occupied": occupied,
        "inspector": inspector?.toJson(),
        "inspection_type": inspectionType?.toJson(),
        "inspection_state": inspectionState?.toJson(),
        "external_unit": externalUnit?.toJson(),
        "inspection_deficiency_inspection":
            inspectionDeficiencyInspection == null
                ? []
                : List<dynamic>.from(
                    inspectionDeficiencyInspection!.map((x) => x.toJson())),
        "type": type?.toJson(),
        "finding_type": findingType?.toJson(),
        "result": result?.toJson(),
        "inspection_building_certificate": inspectionBuildingCertificate == null
            ? []
            : List<dynamic>.from(inspectionBuildingCertificate!.map((x) => x)),
        "general_physical_condition": generalPhysicalCondition,
        "unit_house_keeping": unitHouseKeeping,
        "memo": memo,
        "general_notes": generalNotes,
        "special_amenities": specialAmenities?.toJson(),
        "no_show_image": noShowImage,
        "tenant_signature": tenantSignature,
        "landlord_signature": landlordSignature,
        "start_time": startTime,
        "end_time": endTime,
      };
}

class ExternalUnit {
  int? id;
  String? name;
  String? address;
  int? numberOfBedrooms;
  int? numberOfBathrooms;
  bool? occupied;
  dynamic property;
  dynamic building;
  dynamic apartmentNumber;
  dynamic phone;
  dynamic mobile;
  String? city;
  String? state;
  String? zip;
  Landlord? landlord;
  Tenant? tenant;

  ExternalUnit({
    this.id,
    this.name,
    this.address,
    this.numberOfBedrooms,
    this.numberOfBathrooms,
    this.occupied,
    this.property,
    this.building,
    this.apartmentNumber,
    this.phone,
    this.mobile,
    this.city,
    this.state,
    this.zip,
    this.landlord,
    this.tenant,
  });

  factory ExternalUnit.fromJson(Map<String, dynamic> json) => ExternalUnit(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        numberOfBedrooms: json["number_of_bedrooms"],
        numberOfBathrooms: json["number_of_bathrooms"],
        occupied: json["occupied"],
        property: json["property"],
        building: json["building"],
        apartmentNumber: json["apartment_number"],
        phone: json["phone"],
        mobile: json["mobile"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        landlord: json["landlord"] == null
            ? null
            : Landlord.fromJson(json["landlord"]),
        tenant: json["tenant"] == null ? null : Tenant.fromJson(json["tenant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "number_of_bedrooms": numberOfBedrooms,
        "number_of_bathrooms": numberOfBathrooms,
        "occupied": occupied,
        "property": property,
        "building": building,
        "apartment_number": apartmentNumber,
        "phone": phone,
        "mobile": mobile,
        "city": city,
        "state": state,
        "zip": zip,
        "landlord": landlord?.toJson(),
        "tenant": tenant?.toJson(),
      };
}

class Landlord {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address1;
  dynamic address2;
  String? city;
  dynamic state;
  dynamic zip;
  String? phone;
  String? mobile;
  dynamic email;
  bool? isText;
  bool? isEmail;
  bool? isFax;
  String? name;

  Landlord({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zip,
    this.phone,
    this.mobile,
    this.email,
    this.isText,
    this.isEmail,
    this.isFax,
    this.name,
  });

  factory Landlord.fromJson(Map<String, dynamic> json) => Landlord(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        phone: json["phone"],
        mobile: json["mobile"],
        email: json["email"],
        isText: json["is_text"],
        isEmail: json["is_email"],
        isFax: json["is_fax"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "zip": zip,
        "phone": phone,
        "mobile": mobile,
        "email": email,
        "is_text": isText,
        "is_email": isEmail,
        "is_fax": isFax,
        "name": name,
      };
}

class Tenant {
  int? id;
  FindingType? program;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address1;
  dynamic address2;
  String? city;
  String? mobile;
  dynamic email;
  bool? isText;
  bool? isEmail;
  bool? isFax;
  String? firstName;
  String? lastName;
  dynamic lastFourSsn;
  String? tenantId;
  dynamic typeHousing;
  dynamic middleInitial;
  dynamic dateOfBirth;
  dynamic sex;
  String? phone;
  String? zip;
  String? state;

  Tenant({
    this.id,
    this.program,
    this.createdAt,
    this.updatedAt,
    this.address1,
    this.address2,
    this.city,
    this.mobile,
    this.email,
    this.isText,
    this.isEmail,
    this.isFax,
    this.firstName,
    this.lastName,
    this.lastFourSsn,
    this.tenantId,
    this.typeHousing,
    this.middleInitial,
    this.dateOfBirth,
    this.sex,
    this.phone,
    this.zip,
    this.state,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        id: json["id"],
        program: json["program"] == null
            ? null
            : FindingType.fromJson(json["program"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        mobile: json["mobile"],
        email: json["email"],
        isText: json["is_text"],
        isEmail: json["is_email"],
        isFax: json["is_fax"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        lastFourSsn: json["last_four_ssn"],
        tenantId: json["tenant_id"],
        typeHousing: json["type_housing"],
        middleInitial: json["middle_initial"],
        dateOfBirth: json["date_of_birth"],
        sex: json["sex"],
        phone: json["phone"],
        zip: json["zip"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "program": program?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "address1": address1,
        "address2": address2,
        "city": city,
        "mobile": mobile,
        "email": email,
        "is_text": isText,
        "is_email": isEmail,
        "is_fax": isFax,
        "first_name": firstName,
        "last_name": lastName,
        "last_four_ssn": lastFourSsn,
        "tenant_id": tenantId,
        "type_housing": typeHousing,
        "middle_initial": middleInitial,
        "date_of_birth": dateOfBirth,
        "sex": sex,
        "phone": phone,
        "zip": zip,
        "state": state,
      };
}

class FindingType {
  int? id;
  String? value;

  FindingType({
    this.id,
    this.value,
  });

  factory FindingType.fromJson(Map<String, dynamic> json) => FindingType(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
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

  DeficiencyInspectionDeficiencyProofPicture({
    this.picture,
    this.description,
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
  int? id;
  Severity? severity;
  HousingItem? housingItem;
  String? correctionTimeFrame;

  HousingDeficiency({
    this.id,
    this.severity,
    this.housingItem,
    this.correctionTimeFrame,
  });

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

  Severity({
    this.id,
    this.healthySafetyDesignation,
  });

  factory Severity.fromJson(Map<String, dynamic> json) => Severity(
        id: json["id"],
        healthySafetyDesignation: json["healthy_safety_designation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "healthy_safety_designation": healthySafetyDesignation,
      };
}

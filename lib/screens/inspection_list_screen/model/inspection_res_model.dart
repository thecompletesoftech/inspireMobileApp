// To parse this JSON data, do
//
//     final inspectionResponseModel = inspectionResponseModelFromJson(jsonString);

import 'dart:convert';

InspectionResponseModel inspectionResponseModelFromJson(String str) =>
    InspectionResponseModel.fromJson(json.decode(str));

String inspectionResponseModelToJson(InspectionResponseModel data) =>
    json.encode(data.toJson());

class InspectionResponseModel {
  String? type;
  List<ScheduleInspection>? scheduleInspections;

  InspectionResponseModel({this.type, this.scheduleInspections});

  factory InspectionResponseModel.fromJson(Map<String, dynamic> json) =>
      InspectionResponseModel(
        type: json["type"],
        scheduleInspections: json["schedule_inspections"] == null
            ? []
            : List<ScheduleInspection>.from(json["schedule_inspections"]!
                .map((x) => ScheduleInspection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "schedule_inspections": scheduleInspections == null
            ? []
            : List<dynamic>.from(scheduleInspections!.map((x) => x.toJson())),
      };
}

class ScheduleInspection {
  int? id;
  DateTime? scheduleDate;
  Status? status;
  Inspector? inspector;
  dynamic property;
  List<ScheduleInspectionBuilding>? scheduleInspectionBuildings;
  String? formattedScheduleDate;
  Status? type;
  String? startTime;
  String? endTime;
  InspectionType? inspectionType;

  ScheduleInspection({
    this.id,
    this.scheduleDate,
    this.status,
    this.inspector,
    this.property,
    this.scheduleInspectionBuildings,
    this.formattedScheduleDate,
    this.type,
    this.startTime,
    this.endTime,
    this.inspectionType,
  });

  factory ScheduleInspection.fromJson(Map<String, dynamic> json) =>
      ScheduleInspection(
        id: json["id"],
        scheduleDate: json["schedule_date"] == null
            ? null
            : DateTime.parse(json["schedule_date"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        inspector: json["inspector"] == null
            ? null
            : Inspector.fromJson(json["inspector"]),
        property: json["property"],
        scheduleInspectionBuildings:
            json["schedule_inspection_buildings"] == null
                ? []
                : List<ScheduleInspectionBuilding>.from(
                    json["schedule_inspection_buildings"]!
                        .map((x) => ScheduleInspectionBuilding.fromJson(x))),
        formattedScheduleDate: json["formatted_schedule_date"],
        type: json["type"] == null ? null : Status.fromJson(json["type"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        inspectionType: json["inspection_type"] == null
            ? null
            : InspectionType.fromJson(json["inspection_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schedule_date": scheduleDate?.toIso8601String(),
        "status": status?.toJson(),
        "inspector": inspector?.toJson(),
        "property": property,
        "schedule_inspection_buildings": scheduleInspectionBuildings == null
            ? []
            : List<dynamic>.from(
                scheduleInspectionBuildings!.map((x) => x.toJson())),
        "formatted_schedule_date": formattedScheduleDate,
        "type": type?.toJson(),
        "start_time": startTime,
        "end_time": endTime,
        "inspection_type": inspectionType?.toJson(),
      };
}

class InspectionType {
  int? id;
  String? type;
  dynamic description;

  InspectionType({
    this.id,
    this.type,
    this.description,
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
  int? id;
  int? externalAccountId;
  dynamic externalPersonalId;
  String? name;

  Inspector({
    this.id,
    this.externalAccountId,
    this.externalPersonalId,
    this.name,
  });

  factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
        id: json["id"],
        externalAccountId: json["external_account_id"],
        externalPersonalId: json["external_personal_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "external_account_id": externalAccountId,
        "external_personal_id": externalPersonalId,
        "name": name,
      };
}

class ScheduleInspectionBuilding {
  int? id;
  bool? isBuildingInspection;
  dynamic building;
  List<ScheduleInspectionUnit>? scheduleInspectionUnits;
  Status? inspectionStatus;

  ScheduleInspectionBuilding({
    this.id,
    this.isBuildingInspection,
    this.building,
    this.scheduleInspectionUnits,
    this.inspectionStatus,
  });

  factory ScheduleInspectionBuilding.fromJson(Map<String, dynamic> json) =>
      ScheduleInspectionBuilding(
        id: json["id"],
        isBuildingInspection: json["is_building_inspection"],
        building: json["building"],
        scheduleInspectionUnits: json["schedule_inspection_units"] == null
            ? []
            : List<ScheduleInspectionUnit>.from(
                json["schedule_inspection_units"]!
                    .map((x) => ScheduleInspectionUnit.fromJson(x))),
        inspectionStatus: json["inspection_status"] == null
            ? null
            : Status.fromJson(json["inspection_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_building_inspection": isBuildingInspection,
        "building": building,
        "schedule_inspection_units": scheduleInspectionUnits == null
            ? []
            : List<dynamic>.from(
                scheduleInspectionUnits!.map((x) => x.toJson())),
        "inspection_status": inspectionStatus?.toJson(),
      };
}

class Status {
  int? id;
  String? value;

  Status({
    this.id,
    this.value,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}

class ScheduleInspectionUnit {
  int? id;
  Units? unit;
  Status? inspectionStatus;

  ScheduleInspectionUnit({
    this.id,
    this.unit,
    this.inspectionStatus,
  });

  factory ScheduleInspectionUnit.fromJson(Map<String, dynamic> json) =>
      ScheduleInspectionUnit(
        id: json["id"],
        unit: json["unit"] == null ? null : Units.fromJson(json["unit"]),
        inspectionStatus: json["inspection_status"] == null
            ? null
            : Status.fromJson(json["inspection_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit": unit?.toJson(),
        "inspection_status": inspectionStatus?.toJson(),
      };
}

class Units {
  int? id;
  String? name;
  String? address;
  int? numberOfBedrooms;
  dynamic numberOfBathrooms;
  bool? occupied;
  dynamic apartmentNumber;
  dynamic phone;
  dynamic mobile;
  String? city;
  String? state;
  String? zip;
  Landlord? landlord;
  Tenant? tenant;

  Units({
    this.id,
    this.name,
    this.address,
    this.numberOfBedrooms,
    this.numberOfBathrooms,
    this.occupied,
    this.apartmentNumber,
    this.phone,
    this.mobile,
    this.city,
    this.state,
    this.zip,
    this.landlord,
    this.tenant,
  });

  factory Units.fromJson(Map<String, dynamic> json) => Units(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        numberOfBedrooms: json["number_of_bedrooms"],
        numberOfBathrooms: json["number_of_bathrooms"],
        occupied: json["occupied"],
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
  Status? program;
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
        program:
            json["program"] == null ? null : Status.fromJson(json["program"]),
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

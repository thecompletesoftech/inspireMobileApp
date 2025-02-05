// To parse this JSON data, do
//
//     final noShowReqModel = noShowReqModelFromJson(jsonString);

import 'dart:convert';

import 'package:public_housing/screens/inspection_list_screen/model/inspection_req_model.dart';

NoShowReqModel noShowReqModelFromJson(String str) =>
    NoShowReqModel.fromJson(json.decode(str));

String noShowReqModelToJson(NoShowReqModel data) => json.encode(data.toJson());

class NoShowReqModel {
  InspectionsData? inspection;
  Unit? unit;
  List<DeficiencyInspection>? deficiencyInspections;

  NoShowReqModel({
    this.inspection,
    this.unit,
    this.deficiencyInspections,
  });

  factory NoShowReqModel.fromJson(Map<String, dynamic> json) => NoShowReqModel(
        inspection: json["inspection"] == null
            ? null
            : InspectionsData.fromJson(json["inspection"]),
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

class InspectionsData {
  String? inspectorId;
  DateTime? date;
  String? startTime;
  String? endTime;
  String? comment;
  String? inspectionStateId;
  String? inspectionTypeId;
  String? noShowImage;
  int? findingType;
  int? result;
  int? scheduleInspectionId;

  InspectionsData({
    this.inspectorId,
    this.date,
    this.startTime,
    this.endTime,
    this.comment,
    this.inspectionStateId,
    this.inspectionTypeId,
    this.noShowImage,
    this.findingType,
    this.result,
    this.scheduleInspectionId,
  });

  factory InspectionsData.fromJson(Map<String, dynamic> json) =>
      InspectionsData(
        inspectorId: json["inspector_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        comment: json["comment"],
        inspectionStateId: json["inspection_state_id"],
        inspectionTypeId: json["inspection_type_id"],
        noShowImage: json["no_show_image"],
        findingType: json["finding_type"],
        result: json["result"],
        scheduleInspectionId: json["schedule_inspection_id"],
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
        "finding_type": findingType,
        "result": result,
        "schedule_inspection_id": scheduleInspectionId,
      };
}

// To parse this JSON data, do
//
//     final resultResponseModel = resultResponseModelFromJson(jsonString);

import 'dart:convert';

ResultResponseModel resultResponseModelFromJson(String str) =>
    ResultResponseModel.fromJson(json.decode(str));

String resultResponseModelToJson(ResultResponseModel data) =>
    json.encode(data.toJson());

class ResultResponseModel {
  String? type;
  List<List<dynamic>>? results;

  ResultResponseModel({
    this.type,
    this.results,
  });

  factory ResultResponseModel.fromJson(Map<String, dynamic> json) =>
      ResultResponseModel(
        type: json["type"],
        results: json["results"] == null
            ? []
            : List<List<dynamic>>.from(json["results"]!
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "results": results == null
            ? []
            : List<dynamic>.from(
                results!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

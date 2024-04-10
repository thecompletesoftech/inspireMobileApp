import 'dart:convert';

OfflineDatabaseModel fromJson({required String str}) {
  final jsonData = json.decode(str);
  return OfflineDatabaseModel.fromMap(jsonData);
}

String toJson(OfflineDatabaseModel databaseModel) {
  final dyn = databaseModel.toMap();
  return json.encode(dyn);
}

class OfflineDatabaseModel {
  String? id;
  String? title;
  String? description;
  String? newsLink;
  String? category;
  String? footerTitle;

  OfflineDatabaseModel(
      {this.id,
      this.title,
      this.description,
      this.newsLink,
      this.category,
      this.footerTitle});

  factory OfflineDatabaseModel.fromMap(Map<String, dynamic> json) =>
      OfflineDatabaseModel(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          newsLink: json['newsLink'],
          category: json['category'],
          footerTitle: json['footerTitle']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'newsLink': newsLink,
        'category': category,
        'footerTitle': footerTitle
      };
}

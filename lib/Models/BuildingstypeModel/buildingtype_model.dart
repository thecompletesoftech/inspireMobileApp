class BuildingTypesModel {
  String? type;
  List<BuildingTypes>? buildingTypes;

  BuildingTypesModel({this.type, this.buildingTypes});

  BuildingTypesModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['building_types'] != null) {
      buildingTypes = <BuildingTypes>[];
      json['building_types'].forEach((v) {
        buildingTypes!.add(new BuildingTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.buildingTypes != null) {
      data['building_types'] =
          this.buildingTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BuildingTypes {
  int? id;
  String? name;
  Null? description;

  BuildingTypes({this.id, this.name, this.description});

  BuildingTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

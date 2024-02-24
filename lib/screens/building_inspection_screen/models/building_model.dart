class BuildingModel {
  String? type;
  List<Buildings>? buildings;

  BuildingModel({this.type, this.buildings});

  BuildingModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['buildings'] != null) {
      buildings = <Buildings>[];
      json['buildings'].forEach((v) {
        buildings!.add(new Buildings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.buildings != null) {
      data['buildings'] = this.buildings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Buildings {
  int? id;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? name;
  String? number;
  Property? property;
  String? constructedYear;
  BuildingType? buildingType;

  Buildings(
      {this.id,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zip,
      this.name,
      this.number,
      this.property,
      this.constructedYear,
      this.buildingType});

  Buildings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    name = json['name'];
    number = json['number'];
    property = json['property'] != null
        ? new Property.fromJson(json['property'])
        : null;
    constructedYear = json['constructed_year'];
    buildingType = json['building_type'] != null
        ? new BuildingType.fromJson(json['building_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['name'] = this.name;
    data['number'] = this.number;
    if (this.property != null) {
      data['property'] = this.property!.toJson();
    }
    data['constructed_year'] = this.constructedYear;
    if (this.buildingType != null) {
      data['building_type'] = this.buildingType!.toJson();
    }
    return data;
  }
}

class Property {
  int? id;
  String? address1;

  Property({this.id, this.address1});

  Property.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address1 = json['address1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address1'] = this.address1;
    return data;
  }
}

class BuildingType {
  String? name;
  String? description;

  BuildingType({this.name, this.description});

  BuildingType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

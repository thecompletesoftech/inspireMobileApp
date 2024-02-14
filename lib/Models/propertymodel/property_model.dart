class PropertyModel {
  String? type;
  List<Properties>? properties;

  PropertyModel({this.type, this.properties});

  PropertyModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(new Properties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Properties {
  int? id;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? name;
  String? number;
  String? ampNumber;
  String? notes;

  Properties(
      {this.id,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zip,
      this.name,
      this.number,
      this.ampNumber,
      this.notes});

  Properties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    name = json['name'];
    number = json['number'];
    ampNumber = json['amp_number'];
    notes = json['notes'];
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
    data['amp_number'] = this.ampNumber;
    data['notes'] = this.notes;
    return data;
  }
}
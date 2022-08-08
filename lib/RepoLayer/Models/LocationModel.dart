class LocationModel {
  String? name;
  String? administrativeArea;

  LocationModel(
      {this.name, this.administrativeArea});

  LocationModel.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    administrativeArea = json['administrativeArea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['administrativeArea'] = administrativeArea;
    return data;
  }
}

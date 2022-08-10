class ConnectionModel {
  String? name;
  int? idType;
  int? id;

  ConnectionModel({this.name, this.idType, this.id});

  ConnectionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    idType = json['idType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['idType'] = idType;
    data['id'] = id;
    return data;
  }
}

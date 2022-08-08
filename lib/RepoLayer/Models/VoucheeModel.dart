import 'ConnectionModel.dart';
import 'PhotosModel.dart';

class VoucheeModel {
  String? id;
  String? dateCreated;
  String? firstName;
  String? lastName;
  String? middleName;
  String? voucherRefId;
  String? voice;
  String? nationality;
  String? dob;
  int? gender;
  int? digitalId;
  List<PhotosModel>? photos;
  List<ConnectionModel>? connection;

  VoucheeModel(
      {this.id,
      this.dateCreated,
      this.firstName,
      this.lastName,
      this.middleName,
      this.voucherRefId,
      this.voice,
      this.nationality,
      this.dob,
      this.gender,
      this.digitalId,
      this.photos,
      this.connection});

  VoucheeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['dateCreated'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    voucherRefId = json['voucherRefId'];
    voice = json['voice'];
    nationality = json['nationality'];
    dob = json['dob'];
    gender = json['gender'];
    digitalId = json['digitalId'];
    if (json['photos'] != null) {
      photos = <PhotosModel>[];
      json['photos'].forEach((v) {
        photos!.add(PhotosModel.fromJson(v));
      });
    }
    if (json['connection'] != null) {
      connection = <ConnectionModel>[];
      json['connection'].forEach((v) {
        connection!.add(ConnectionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['voucherRefId'] = voucherRefId;
    data['voice'] = voice;
    data['nationality'] = nationality;
    data['dob'] = dob;
    data['gender'] = gender;
    data['digitalId'] = digitalId;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    if (connection != null) {
      data['connection'] = connection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:digital_identity_ui/Enums/Enums/ModelEnums.dart';
import 'package:digital_identity_ui/RepoLayer/Models/ConnectionModel.dart';
import 'package:digital_identity_ui/RepoLayer/Models/LocationModel.dart';
import 'package:digital_identity_ui/RepoLayer/Models/PhotosModel.dart';
import 'package:digital_identity_ui/RepoLayer/Models/TokenModel.dart';
import 'package:digital_identity_ui/RepoLayer/Models/VoucheeModel.dart';
import 'package:digital_identity_ui/RepoLayer/Models/VoucherModel.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  var dio = Dio();

  final String apiUrl = "https://ab48-197-232-61-244.eu.ngrok.io/api/";
  String authUrl = "https://api-omnichannel-dev.azure-api.net/v2.1/oauth/token";
  Future<String> getToken() async {
    Uri urlvalue = Uri.parse(authUrl);

    http.Response resp = await http.post(urlvalue,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body:
            "client_secret=OTI0QUFGRTMtMjc3My00QUNELUFGMzktQjkzQzUwNzA4RjhD&client_id=A39A9A4B8B8D406&grant_type=client_credentials");
    var result = TokenModel.fromJson(jsonDecode(resp.body));
    return result.accessToken.toString();
  }

  Future<List<dynamic>> getAll(String url, ModelEnums type) async {
    String token = await getToken();

    http.Response res = await http.get(Uri.parse('$apiUrl$url'),
        headers: {HttpHeaders.authorizationHeader: token});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<dynamic> result = [];
      switch (type) {
        case ModelEnums.ConnectionModel:
          result = body
              .map((dynamic item) => ConnectionModel.fromJson(item))
              .toList();
          break;
        case ModelEnums.LocationModel:
          result =
              body.map((dynamic item) => LocationModel.fromJson(item)).toList();
          break;
        case ModelEnums.VoucheeModel:
          result =
              body.map((dynamic item) => VoucheeModel.fromJson(item)).toList();
          break;
        case ModelEnums.VoucherModel:
          result =
              body.map((dynamic item) => VoucherModel.fromJson(item)).toList();
          break;
        case ModelEnums.PhotosModel:
          result =
              body.map((dynamic item) => PhotosModel.fromJson(item)).toList();
          break;
        default:
      }
      return result;
    } else {
      throw "Failed to load the list";
    }
  }

  Future<dynamic> getById(String url, String id, ModelEnums type) async {
    String token = await getToken();
    final response = await http.get(Uri.parse('$apiUrl$url/$id'),
        headers: {HttpHeaders.authorizationHeader: token});

    if (response.body.isNotEmpty) {
      var result;
      var body = jsonDecode(response.body);
      switch (type) {
        case ModelEnums.ConnectionModel:
          result = ConnectionModel.fromJson(body);
          break;
        case ModelEnums.LocationModel:
          result = LocationModel.fromJson(body);
          break;
        case ModelEnums.VoucheeModel:
          result = VoucheeModel.fromJson(body);
          break;
        case ModelEnums.VoucherModel:
          result = VoucherModel.fromJson(body);
          break;
        case ModelEnums.PhotosModel:
          result = PhotosModel.fromJson(body);
          break;
        default:
      }
      return result;
    } else {
      throw Exception('Failed to load the data');
    }
  }

  Future<String> create(Map data, String url) async {
    String token = await getToken();
    final http.Response response = await http.post(
      Uri.parse('$apiUrl$url'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: token
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "false";
    }
  }

  Future<bool> updateid(String url, String id, Map data) async {
    String token = await getToken();
    final http.Response response = await http.patch(
      Uri.parse('$apiUrl$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteid(String url, String id) async {
    String token = await getToken();
    http.Response res = await http.delete(Uri.parse('$apiUrl$url/$id'),
        headers: {HttpHeaders.authorizationHeader: token});

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

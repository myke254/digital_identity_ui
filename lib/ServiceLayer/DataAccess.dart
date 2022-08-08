import 'package:digital_identity_ui/Enums/Enums/ModelEnums.dart';
import 'package:digital_identity_ui/ServiceLayer/ApiService.dart';

class DataAccess<T> {
  Future<List<T>> getAll(String url, ModelEnums type) async =>
      await ApiService().getAll(url, type) as List<T>;
  Future<T> get(String url, String id, ModelEnums type) async =>
      await ApiService().getById(url, id, type) as T;
  Future<bool> update(String url, String id, Map data) async =>
      await ApiService().updateid(url, id, data);
  Future<bool> delete(String url, String id) async =>
      await ApiService().deleteid(url, id);
}

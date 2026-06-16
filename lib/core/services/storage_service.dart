import 'package:localstorage/localstorage.dart';

class StorageService {
  Future<void> setString(String key, String value) async {
    localStorage.setItem(key, value);
  }

  String? getString(String key) {
    return localStorage.getItem(key);
  }

  Future<void> remove(String key) async {
    localStorage.removeItem(key);
  }

  Future<void> clear() async {
    localStorage.clear();
  }
}

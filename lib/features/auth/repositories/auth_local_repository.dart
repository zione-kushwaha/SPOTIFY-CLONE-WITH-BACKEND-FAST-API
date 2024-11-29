import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_local_repository.g.dart';

@riverpod
AuthLocalRepository authLocalRepository(Ref ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;

  AuthLocalRepository() {
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

//set the token
  Future<void> setToken(String? token) async {
    if (token == null) {
      return;
    }
    await _sharedPreferences.setString('token', token);
  }

  // get the token
  String? getToken() {
    return _sharedPreferences.getString('token');
  }
}

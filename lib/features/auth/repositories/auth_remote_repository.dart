import 'dart:convert';
import 'package:day6/core/constants/server_constant.dart';
import 'package:day6/core/failure/failure.dart';
import 'package:day6/features/auth/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<FailureApp, UserModel>> signupUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.BASE_URL}auth/signup/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        return Left(FailureApp(resBodyMap['detail']));
      }

      print(resBodyMap);
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }

  Future<Either<FailureApp, UserModel>> loginUser(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.BASE_URL}auth/login/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(FailureApp(resBodyMap['detail']));
      }

      return Right(UserModel.fromMap(resBodyMap['user']).copyWith(
        token: resBodyMap['token'],
      ));
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }
}

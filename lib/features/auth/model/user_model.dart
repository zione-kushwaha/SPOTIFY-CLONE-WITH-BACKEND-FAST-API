// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String id;
  final String token;

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.token,
  });

  UserModel copyWith({String? name, String? email, String? id, String? token}) {
    return UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        id: id ?? this.id,
        token: token ?? this.token);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
      token: map['token'] ?? '',
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'id': id,
      'token': token,
    };
  }
}

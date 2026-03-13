import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_jwt.g.dart';

/// Represents a user credentials for JWT authentication.
@JsonSerializable()
class UserJWT extends Equatable {
  @JsonKey(name: 'username')
  final String? username;

  @JsonKey(name: 'password')
  final String? password;

  const UserJWT(this.username, this.password);

  factory UserJWT.fromJson(Map<String, dynamic> json) => _$UserJWTFromJson(json);

  Map<String, dynamic> toJson() => _$UserJWTToJson(this);

  UserJWT copyWith({String? username, String? password}) {
    return UserJWT(username ?? this.username, password ?? this.password);
  }

  // Métodos de utilidad (mantenidos por compatibilidad)

  static UserJWT? fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return UserJWT.fromJson(json);
  }

  @override
  List<Object?> get props => [username, password];

  @override
  bool get stringify => true;
}
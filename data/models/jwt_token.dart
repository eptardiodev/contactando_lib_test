import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jwt_token.g.dart';

/// Represents a JWT token response.
@JsonSerializable()
class JWTToken extends Equatable {
  @JsonKey(name: 'id_token')
  final String? idToken;

  const JWTToken({this.idToken});

  factory JWTToken.fromJson(Map<String, dynamic> json) => _$JWTTokenFromJson(json);

  Map<String, dynamic> toJson() => _$JWTTokenToJson(this);

  JWTToken copyWith({String? idToken}) {
    return JWTToken(idToken: idToken ?? this.idToken);
  }

  // Métodos de utilidad (mantenidos por compatibilidad)

  static JWTToken? fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return JWTToken.fromJson(json);
  }

  @override
  List<Object?> get props => [idToken];

  @override
  bool get stringify => true;
}
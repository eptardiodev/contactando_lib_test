import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// ApplicationUser model that represents the user entity in this application.
///
/// This is an immutable class that extends [Equatable] so that it can be compared.
@JsonSerializable()
class User extends Equatable {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'login')
  final String? login;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'activated')
  final bool? activated;

  @JsonKey(name: 'langKey')
  final String? langKey;

  @JsonKey(name: 'createdBy')
  final String? createdBy;

  @JsonKey(name: 'createdDate')
  final DateTime? createdDate;

  @JsonKey(name: 'lastModifiedBy')
  final String? lastModifiedBy;

  @JsonKey(name: 'lastModifiedDate')
  final DateTime? lastModifiedDate;

  @JsonKey(name: 'authorities')
  final List<String>? authorities;

  const User({
    this.id,
    this.login,
    this.firstName,
    this.lastName,
    this.email,
    this.activated,
    this.langKey,
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.authorities,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// CopyWith method to create a new instance of the User class with new values
  User copyWith({
  String? id,
  String? login,
  String? firstName,
  String? lastName,
  String? email,
  bool? activated,
  String? langKey,
  String? createdBy,
  DateTime? createdDate,
  String? lastModifiedBy,
  DateTime? lastModifiedDate,
  List<String>? authorities,
  }) {
  return User(
  id: id ?? this.id,
  login: login ?? this.login,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  email: email ?? this.email,
  activated: activated ?? this.activated,
  langKey: langKey ?? this.langKey,
  createdBy: createdBy ?? this.createdBy,
  createdDate: createdDate ?? this.createdDate,
  lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
  lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
  authorities: authorities ?? this.authorities,
  );
  }

  // Métodos de utilidad (mantenidos por compatibilidad)

  static User? fromJsonString(String jsonString) {
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  return User.fromJson(json);
  }

  static List<User> fromJsonList(List<dynamic> jsonList) {
  return jsonList
      .whereType<Map<String, dynamic>>()
      .map((e) => User.fromJson(e))
      .toList();
  }

  static List<User> fromJsonStringList(String jsonString) {
  final jsonList = jsonDecode(jsonString) as List;
  return fromJsonList(jsonList);
  }

  @override
  List<Object?> get props => [
  id,
  login,
  firstName,
  lastName,
  email,
  activated,
  langKey,
  createdBy,
  createdDate,
  lastModifiedBy,
  lastModifiedDate,
  authorities,
  ];

  @override
  bool get stringify => true;
}
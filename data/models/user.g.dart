// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String?,
  login: json['login'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  activated: json['activated'] as bool?,
  langKey: json['langKey'] as String?,
  createdBy: json['createdBy'] as String?,
  createdDate: json['createdDate'] == null
      ? null
      : DateTime.parse(json['createdDate'] as String),
  lastModifiedBy: json['lastModifiedBy'] as String?,
  lastModifiedDate: json['lastModifiedDate'] == null
      ? null
      : DateTime.parse(json['lastModifiedDate'] as String),
  authorities: (json['authorities'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'activated': instance.activated,
  'langKey': instance.langKey,
  'createdBy': instance.createdBy,
  'createdDate': instance.createdDate?.toIso8601String(),
  'lastModifiedBy': instance.lastModifiedBy,
  'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
  'authorities': instance.authorities,
};

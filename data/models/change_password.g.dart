// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordChangeDTO _$PasswordChangeDTOFromJson(Map<String, dynamic> json) =>
    PasswordChangeDTO(
      currentPassword: json['currentPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$PasswordChangeDTOToJson(PasswordChangeDTO instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
    };

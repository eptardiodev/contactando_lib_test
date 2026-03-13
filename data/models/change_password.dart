import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password.g.dart';

/// Data Transfer Object for changing user password.
@JsonSerializable()
class PasswordChangeDTO extends Equatable {
  @JsonKey(name: 'currentPassword')
  final String? currentPassword;

  @JsonKey(name: 'newPassword')
  final String? newPassword;

  const PasswordChangeDTO({this.currentPassword, this.newPassword});

  factory PasswordChangeDTO.fromJson(Map<String, dynamic> json) =>
      _$PasswordChangeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordChangeDTOToJson(this);

  PasswordChangeDTO copyWith({
    String? currentPassword,
    String? newPassword,
  }) {
    return PasswordChangeDTO(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  // Métodos de utilidad (mantenidos por compatibilidad)

  static PasswordChangeDTO? fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return PasswordChangeDTO.fromJson(json);
  }

  @override
  List<Object?> get props => [currentPassword, newPassword];

  @override
  bool get stringify => true;
}
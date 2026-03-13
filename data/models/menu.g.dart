// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  url: json['url'] as String? ?? '',
  icon: json['icon'] as String? ?? '',
  orderPriority: (json['orderPriority'] as num?)?.toInt() ?? 0,
  active: json['active'] as bool? ?? false,
  parent: json['parent'] == null
      ? null
      : Menu.fromJson(json['parent'] as Map<String, dynamic>),
  level: (json['level'] as num?)?.toInt() ?? 0,
  leaf: json['leaf'] as bool? ?? false,
  authorities:
      (json['authorities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'url': instance.url,
  'icon': instance.icon,
  'orderPriority': instance.orderPriority,
  'active': instance.active,
  'parent': instance.parent?.toJson(),
  'level': instance.level,
  'leaf': instance.leaf,
  'authorities': instance.authorities,
};

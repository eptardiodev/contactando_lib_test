import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

/// Menu object
/// Example:
/// id	name	description	url	icon	order_priority	active	parent_id	level
// 1	home	home	/	icon	0	1		0
// 2	account	account	branch	icon	4	1	1	1
// 3	logout	logout	/logout	icon	1	1	2	2
// 4	login	login	/login	icon	2	1	2	2
// 5	settings	settings	branch	icon	3	1	1	1

/// Immutable menu model that extends [Equatable] for value-based comparison.
@JsonSerializable(explicitToJson: true)
class Menu extends Equatable {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'icon')
  final String icon;

  @JsonKey(name: 'orderPriority')
  final int orderPriority;

  @JsonKey(name: 'active')
  final bool active;

  @JsonKey(name: 'parent')
  final Menu? parent;

  @JsonKey(name: 'level')
  final int level;

  @JsonKey(name: 'leaf')
  final bool? leaf;

  @JsonKey(name: 'authorities')
  final List<String>? authorities;

  const Menu({
    this.id = '',
    this.name = '',
    this.description = '',
    this.url = '',
    this.icon = '',
    this.orderPriority = 0,
    this.active = false,
    this.parent,
    this.level = 0,
    this.leaf = false,
    this.authorities = const [],
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);

  Menu copyWith({
    String? id,
    String? name,
    String? description,
    String? url,
    String? icon,
    int? orderPriority,
    bool? active,
    Menu? parent,
    int? level,
    bool? leaf,
    List<String>? authorities,
  }) {
    return Menu(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      orderPriority: orderPriority ?? this.orderPriority,
      active: active ?? this.active,
      parent: parent ?? this.parent,
      level: level ?? this.level,
      leaf: leaf ?? this.leaf,
      authorities: authorities ?? this.authorities,
    );
  }

  // Métodos de utilidad (opcionales, si los usas en tu app)

  static List<Menu> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .whereType<Map<String, dynamic>>()
        .map((e) => Menu.fromJson(e))
        .toList();
  }

  static Menu? fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return Menu.fromJson(json);
  }

  static List<Menu> fromJsonStringList(String jsonString) {
    final jsonList = jsonDecode(jsonString) as List;
    return fromJsonList(jsonList);
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    url,
    icon,
    orderPriority,
    active,
    parent,
    level,
    leaf,
    authorities,
  ];

  @override
  bool get stringify => true;
}
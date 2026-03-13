import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  final int? id;
  final String usuarioId;
  final String nombre;
  final String telefono;
  final String? email;
  final String? foto;
  final DateTime? fechaCreacion;
  final String? notas;
  final String? etiquetas;
  final bool activo;
  final String? direccion;
  final String? tarjeta;
  final String? pais;

  const ContactModel({
    this.id,
    required this.usuarioId,
    required this.nombre,
    required this.telefono,
    this.email,
    this.foto,
    this.fechaCreacion,
    this.notas,
    this.etiquetas,
    this.activo = true,
    this.direccion,
    this.tarjeta,
    this.pais,
  });

  factory ContactModel.empty() => const ContactModel(
        id: 0,
        usuarioId: "272ecaa0-14d3-4c21-8893-a929afb1ced9",
        nombre: '',
        telefono: '',
        activo: true,
      );

  ContactModel copyWith({
    int? id,
    String? usuarioId,
    String? nombre,
    String? telefono,
    String? email,
    String? foto,
    DateTime? fechaCreacion,
    String? notas,
    String? etiquetas,
    bool? activo,
    String? direccion,
    String? tarjeta,
    String? pais,
  }) {
    return ContactModel(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      foto: foto ?? this.foto,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      notas: notas ?? this.notas,
      etiquetas: etiquetas ?? this.etiquetas,
      activo: activo ?? this.activo,
      direccion: direccion ?? this.direccion,
      tarjeta: tarjeta ?? this.tarjeta,
      pais: pais ?? this.pais,
    );
  }

  @override
  List<Object?> get props => [
        id, usuarioId, nombre, telefono, email, foto,
        fechaCreacion, notas, etiquetas, activo, direccion, tarjeta, pais,
      ];

  @override
  bool get stringify => true;
}

class ParentescoModel extends Equatable {
  final int id;
  final String nombre;

  const ParentescoModel({required this.id, required this.nombre});

  @override
  List<Object?> get props => [id, nombre];

  @override
  bool get stringify => true;
}

import 'package:contactando_app_gs/configuration/remote_constants.dart';
import 'package:contactando_app_gs/domain/contacts/contacts_model.dart';
import 'package:contactando_app_gs/domain/contacts/i_contact_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Implementación de [IContactApi] usando Supabase.
///
/// ── REST API (uso futuro) ──────────────────────────────────────────────────
/// Si migrás a un backend REST propio, cada método tiene su equivalente
/// comentado usando HttpUtils. Ejemplo:
///
///   GET  /api/contactos?usuario_id=1          → getContactsByUser
///   GET  /api/contactos/{id}                  → getContactById
///   POST /api/contactos                       → addContact
///   PUT  /api/contactos/{id}                  → updateContact
///   DELETE /api/contactos/{id}                → deleteContact
///   GET  /api/parentescos                     → getParentescos
/// ──────────────────────────────────────────────────────────────────────────
class ContactApi implements IContactApi {
  final _supabase = Supabase.instance.client;

  ContactModel _fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json[RemoteConstants.id] as int?,
      usuarioId: json[RemoteConstants.usuario_id] as String,
      nombre: json[RemoteConstants.nombre] ?? '',
      telefono: json[RemoteConstants.telefono] ?? '',
      email: json[RemoteConstants.email],
      foto: json[RemoteConstants.foto],
      fechaCreacion: json[RemoteConstants.fecha_creacion] != null
          ? DateTime.parse(json[RemoteConstants.fecha_creacion])
          : null,
      notas: json[RemoteConstants.notas],
      etiquetas: json[RemoteConstants.etiquetas],
      activo: json[RemoteConstants.activo] ?? true,
      direccion: json[RemoteConstants.direccion],
      tarjeta: json[RemoteConstants.tarjeta],
      pais: json[RemoteConstants.pais],
    );
  }

  Map<String, dynamic> _toJson(ContactModel model) {
    return {
      RemoteConstants.usuario_id: model.usuarioId,
      RemoteConstants.nombre: model.nombre,
      RemoteConstants.telefono: model.telefono,
      RemoteConstants.email: model.email,
      RemoteConstants.foto: model.foto,
      RemoteConstants.fecha_creacion: model.fechaCreacion?.toIso8601String(),
      RemoteConstants.notas: model.notas,
      RemoteConstants.etiquetas: model.etiquetas,
      RemoteConstants.activo: model.activo,
      RemoteConstants.direccion: model.direccion,
      RemoteConstants.tarjeta: model.tarjeta,
      RemoteConstants.pais: model.pais,
    };
  }

  ParentescoModel _parentescoFromJson(Map<String, dynamic> json) {
    return ParentescoModel(
      id: json[RemoteConstants.id] as int,
      nombre: json[RemoteConstants.nombre] ?? '',
    );
  }

  // ── Contacts ──────────────────────────────────────────────────────────────

  @override
  Future<List<ContactModel>> getContactsByUser(String usuarioId) async {
    try {
      final data = await _supabase
          .from(RemoteConstants.contacto)
          .select()
          .eq(RemoteConstants.id, usuarioId)
          .eq("is_contact_role", true)
          .eq("owner_user_id", "e4558909-4e7c-43bd-b08a-14205bf78e23")
          .eq(RemoteConstants.activo, true);

      return data.map<ContactModel>(_fromJson).toList();

      // ── REST (uso futuro) ────────────────────────────────────────────────
      // final response = await HttpUtils.getRequest('/contactos', queryParams: {'usuario_id': usuarioId.toString()});
      // return (jsonDecode(response.body) as List).map((e) => _fromJson(e)).toList();
      // ────────────────────────────────────────────────────────────────────
    } catch (e) {
      throw Exception('Error al obtener contactos: $e');
    }
  }

  @override
  Future<ContactModel?> getContactById(int id) async {
    try {
      final data = await _supabase
          .from(RemoteConstants.contacto)
          .select()
          .eq(RemoteConstants.id, id)
          .maybeSingle();

      return data != null ? _fromJson(data) : null;

      // ── REST (uso futuro) ────────────────────────────────────────────────
      // final response = await HttpUtils.getRequest('/contactos/$id');
      // if (response.statusCode == 404) return null;
      // return _fromJson(jsonDecode(response.body));
      // ────────────────────────────────────────────────────────────────────
    } catch (e) {
      throw Exception('Error al obtener contacto por ID: $e');
    }
  }

  @override
  Future<ContactModel> addContact(ContactModel contact) async {
    try {
      final inserted = await _supabase
          .from(RemoteConstants.contacto)
          .insert(_toJson(contact))
          .select()
          .single();

      return _fromJson(inserted);

      // ── REST (uso futuro) ────────────────────────────────────────────────
      // final response = await HttpUtils.postRequest('/contactos', contact);
      // return _fromJson(jsonDecode(response.body));
      // ────────────────────────────────────────────────────────────────────
    } catch (e) {
      throw Exception('Error al agregar contacto: $e');
    }
  }

  @override
  Future<ContactModel> updateContact(int id, ContactModel contact) async {
    try {
      final updated = await _supabase
          .from(RemoteConstants.contacto)
          .update(_toJson(contact))
          .eq(RemoteConstants.id, id)
          .select()
          .single();

      return _fromJson(updated);

      // ── REST (uso futuro) ────────────────────────────────────────────────
      // final response = await HttpUtils.putRequest('/contactos/$id', contact);
      // return _fromJson(jsonDecode(response.body));
      // ────────────────────────────────────────────────────────────────────
    } catch (e) {
      throw Exception('Error al actualizar contacto: $e');
    }
  }

  @override
  Future<ContactModel> deleteContact(int id) async {
    try {
      // Soft delete: se marca activo = false
      final deleted = await _supabase
          .from(RemoteConstants.contacto)
          .update({RemoteConstants.activo: false})
          .eq(RemoteConstants.id, id)
          .select()
          .single();

      return _fromJson(deleted);

      // ── REST (uso futuro) ────────────────────────────────────────────────
      // await HttpUtils.deleteRequest('/contactos/$id');
      // return contact; // devolvés el que tenías localmente
      // ────────────────────────────────────────────────────────────────────
    } catch (e) {
      throw Exception('Error al eliminar contacto: $e');
    }
  }

  @override
  Future<ContactModel> insertContact(ContactModel contact) => addContact(contact);

  @override
  Future<List<ContactModel>> searchContacts(int usuarioId, String query) async {
    try {
      final data = await _supabase
          .from(RemoteConstants.contacto)
          .select()
          .eq(RemoteConstants.usuario_id, usuarioId)
          .eq(RemoteConstants.activo, true)
          .or('nombre.ilike.%$query%,telefono.like.%$query%,email.ilike.%$query%')
          .order(RemoteConstants.nombre);

      return data.map<ContactModel>(_fromJson).toList();

      // ── REST (uso futuro) ────────────────────────────────────────────────
      // final response = await HttpUtils.getRequest('/contactos/search', queryParams: {'q': query, 'usuario_id': usuarioId.toString()});
      // return (jsonDecode(response.body) as List).map((e) => _fromJson(e)).toList();
      // ────────────────────────────────────────────────────────────────────
    } catch (e) {
      throw Exception('Error en búsqueda de contactos: $e');
    }
  }

  @override
  Future<List<ContactModel>> getContactsByEtiqueta(int usuarioId, String etiqueta) async {
    try {
      final data = await _supabase
          .from(RemoteConstants.contacto)
          .select()
          .eq(RemoteConstants.usuario_id, usuarioId)
          .eq(RemoteConstants.activo, true)
          .textSearch(RemoteConstants.etiquetas, etiqueta)
          .order(RemoteConstants.nombre);

      return data.map<ContactModel>(_fromJson).toList();
    } catch (e) {
      throw Exception('Error al obtener contactos por etiqueta: $e');
    }
  }

  @override
  Future<List<ContactModel>> getContactsByPais(int usuarioId, String pais) async {
    try {
      final data = await _supabase
          .from(RemoteConstants.contacto)
          .select()
          .eq(RemoteConstants.usuario_id, usuarioId)
          .eq(RemoteConstants.activo, true)
          .eq(RemoteConstants.pais, pais)
          .order(RemoteConstants.nombre);

      return data.map<ContactModel>(_fromJson).toList();
    } catch (e) {
      throw Exception('Error al obtener contactos por país: $e');
    }
  }

  // ── Parentescos ───────────────────────────────────────────────────────────

  @override
  Future<List<ParentescoModel>> getParentescos() async {
    try {
      final data = await _supabase
          .from(RemoteConstants.parentesco)
          .select()
          .order(RemoteConstants.nombre);

      return data.map<ParentescoModel>(_parentescoFromJson).toList();

      // ── REST (uso futuro) ────────────────────────────────────────────────
      // final response = await HttpUtils.getRequest('/parentescos');
      // return (jsonDecode(response.body) as List).map((e) => _parentescoFromJson(e)).toList();
      // ────────────────────────────────────────────────────────────────────
    } catch (e) {
      throw Exception('Error al obtener parentescos: $e');
    }
  }

  @override
  Future<ParentescoModel?> getParentescoById(int parentescoId) async {
    try {
      final data = await _supabase
          .from(RemoteConstants.parentesco)
          .select()
          .eq(RemoteConstants.id, parentescoId)
          .maybeSingle();

      return data != null ? _parentescoFromJson(data) : null;
    } catch (e) {
      throw Exception('Error al obtener parentesco $parentescoId: $e');
    }
  }

  // ── Estadísticas ──────────────────────────────────────────────────────────

  @override
  Future<int> getTotalContactsByUser(int usuarioId) async {
    try {
      final response = await _supabase
          .from(RemoteConstants.contacto)
          .select()
          .eq(RemoteConstants.usuario_id, usuarioId)
          .eq(RemoteConstants.activo, true)
          .count(CountOption.exact);

      return response.count ?? 0;
    } catch (e) {
      throw Exception('Error al obtener total de contactos: $e');
    }
  }

  @override
  Future<List<String>> getEtiquetasUnicas(int usuarioId) async {
    try {
      final data = await _supabase
          .from(RemoteConstants.contacto)
          .select(RemoteConstants.etiquetas)
          .eq(RemoteConstants.usuario_id, usuarioId)
          .eq(RemoteConstants.activo, true)
          .not(RemoteConstants.etiquetas, 'is', null);

      final etiquetas = <String>{};
      for (final item in data) {
        final tags = item[RemoteConstants.etiquetas] as String?;
        if (tags != null && tags.isNotEmpty) {
          etiquetas.addAll(tags.split(',').map((e) => e.trim()));
        }
      }
      return etiquetas.toList()..sort();
    } catch (e) {
      throw Exception('Error al obtener etiquetas únicas: $e');
    }
  }

  @override
  Future<List<String>> getPaisesUnicos(String usuarioId) async {
    try {
      final data = await _supabase
          .from(RemoteConstants.contacto)
          .select(RemoteConstants.pais)
          .eq(RemoteConstants.usuario_id, usuarioId)
          .eq(RemoteConstants.activo, true)
          .not(RemoteConstants.pais, 'is', null)
          .order(RemoteConstants.pais);

      final paises = <String>{};
      for (final item in data) {
        final p = item[RemoteConstants.pais] as String?;
        if (p != null) paises.add(p);
      }
      return paises.toList()..sort();
    } catch (e) {
      throw Exception('Error al obtener países únicos: $e');
    }
  }
}

import 'package:contactando_app_gs/domain/contacts/contacts_model.dart';
import 'package:contactando_app_gs/domain/contacts/i_contact_api.dart';
import 'package:contactando_app_gs/domain/contacts/i_contact_repository.dart';

class ContactRepository implements IContactRepository {
  final IContactApi _api;

  ContactRepository(this._api);

  @override
  Future<List<ContactModel>> getContactsByUser(String usuarioId) =>
      _api.getContactsByUser(usuarioId);

  @override
  Future<ContactModel?> getContactById(int id) =>
      _api.getContactById(id);

  @override
  Future<ContactModel> addContact(ContactModel contact) =>
      _api.addContact(contact);

  @override
  Future<ContactModel> updateContact(int id, ContactModel contact) =>
      _api.updateContact(id, contact);

  @override
  Future<ContactModel> deleteContact(int id) =>
      _api.deleteContact(id);

  @override
  Future<List<ContactModel>> searchContacts(int usuarioId, String query) =>
      _api.searchContacts(usuarioId, query);

  @override
  Future<List<ContactModel>> getContactsByEtiqueta(int usuarioId, String etiqueta) =>
      _api.getContactsByEtiqueta(usuarioId, etiqueta);

  @override
  Future<List<ContactModel>> getContactsByPais(int usuarioId, String pais) =>
      _api.getContactsByPais(usuarioId, pais);

  @override
  Future<List<ParentescoModel>> getParentescos() =>
      _api.getParentescos();

  @override
  Future<ParentescoModel?> getParentescoById(int parentescoId) =>
      _api.getParentescoById(parentescoId);

  @override
  Future<int> getTotalContactsByUser(int usuarioId) =>
      _api.getTotalContactsByUser(usuarioId);

  @override
  Future<List<String>> getEtiquetasUnicas(int usuarioId) =>
      _api.getEtiquetasUnicas(usuarioId);

  @override
  Future<List<String>> getPaisesUnicos(String usuarioId) =>
      _api.getPaisesUnicos(usuarioId);
}

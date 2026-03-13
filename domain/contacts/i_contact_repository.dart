import 'package:contactando_app_gs/domain/contacts/contacts_model.dart';

abstract class IContactRepository {
  Future<List<ContactModel>> getContactsByUser(String usuarioId);
  Future<ContactModel?> getContactById(int id);
  Future<ContactModel> addContact(ContactModel contact);
  Future<ContactModel> updateContact(int id, ContactModel contact);
  Future<ContactModel> deleteContact(int id);
  Future<List<ContactModel>> searchContacts(int usuarioId, String query);
  Future<List<ContactModel>> getContactsByEtiqueta(int usuarioId, String etiqueta);
  Future<List<ContactModel>> getContactsByPais(int usuarioId, String pais);
  Future<List<ParentescoModel>> getParentescos();
  Future<ParentescoModel?> getParentescoById(int parentescoId);
  Future<int> getTotalContactsByUser(int usuarioId);
  Future<List<String>> getEtiquetasUnicas(int usuarioId);
  Future<List<String>> getPaisesUnicos(String usuarioId);
}

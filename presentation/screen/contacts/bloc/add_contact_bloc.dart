import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:contactando_app_gs/domain/contacts/contacts_model.dart';
import 'package:contactando_app_gs/domain/contacts/i_contact_repository.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  final IContactRepository _repository;

  AddContactBloc({required IContactRepository repository})
      : _repository = repository,
        super(const AddContactState()) {
    on<AddContactLoadDataEvent>(_onLoadData);
    on<AddContactSubmitEvent>(_onSubmit);
  }

  /// Carga relaciones y países disponibles para los dropdowns del formulario.
  FutureOr<void> _onLoadData(
    AddContactLoadDataEvent event,
    Emitter<AddContactState> emit,
  ) async {
    emit(state.copyWith(status: AddContactStatus.loading));
    try {
      final results = await Future.wait([
        _repository.getParentescos(),
        _repository.getPaisesUnicos(event.usuarioId),
      ]);

      final relaciones = (results[0] as List<ParentescoModel>)
          .map((p) => p.nombre)
          .toList();
      final paises = results[1] as List<String>;

      emit(state.copyWith(
        status: AddContactStatus.initial,
        relaciones: relaciones,
        paises: paises,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AddContactStatus.failure,
        errorMessage: 'Error al cargar datos iniciales: $e',
      ));
    }
  }

  /// Guarda el nuevo contacto.
  FutureOr<void> _onSubmit(
    AddContactSubmitEvent event,
    Emitter<AddContactState> emit,
  ) async {
    emit(state.copyWith(status: AddContactStatus.loading));
    try {
      final newContact = ContactModel(
        usuarioId: event.usuarioId,
        nombre: event.nombre,
        telefono: event.telefono,
        email: event.email,
        foto: event.foto,
        notas: event.notas,
        direccion: event.direccion,
        tarjeta: event.tarjeta,
        pais: event.pais,
        activo: true,
      );

      await _repository.addContact(newContact);

      emit(state.copyWith(status: AddContactStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: AddContactStatus.failure,
        errorMessage: 'Error al guardar el contacto: $e',
      ));
    }
  }
}

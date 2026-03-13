import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:contactando_app_gs/data/api/contact_api.dart';
import 'package:contactando_app_gs/data/repository/contact_repository.dart';
import 'package:contactando_app_gs/presentation/screen/contacts/bloc/add_contact_bloc.dart';

/// Pantalla para agregar un nuevo contacto.
///
/// Provee su propio [AddContactBloc]. Al guardar exitosamente,
/// llama [onContactAdded] y hace pop con `true`.
class AddContactScreen extends StatelessWidget {
  final String usuarioId;
  final VoidCallback? onContactAdded;

  const AddContactScreen({
    super.key,
    required this.usuarioId,
    this.onContactAdded,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddContactBloc(
        repository: ContactRepository(ContactApi()),
      )..add(AddContactLoadDataEvent(usuarioId)),
      child: _AddContactView(usuarioId: usuarioId, onContactAdded: onContactAdded),
    );
  }
}

class _AddContactView extends StatefulWidget {
  final String usuarioId;
  final VoidCallback? onContactAdded;

  const _AddContactView({required this.usuarioId, this.onContactAdded});

  @override
  State<_AddContactView> createState() => _AddContactViewState();
}

class _AddContactViewState extends State<_AddContactView> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _notasController = TextEditingController();
  final _direccionController = TextEditingController();
  final _tarjetaController = TextEditingController();
  String? _relacionSeleccionada;
  String? _paisSeleccionado;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddContactBloc, AddContactState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AddContactStatus.success) {
          widget.onContactAdded?.call();
          Navigator.of(context).pop(true);
        }
        if (state.status == AddContactStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Error desconocido'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Agregar Contacto'),
            actions: [
              TextButton(
                onPressed: state.status == AddContactStatus.loading
                    ? null
                    : _guardar,
                child: state.status == AddContactStatus.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('GUARDAR'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildPhotoSection(),
                  const SizedBox(height: 24),
                  _buildTextField(
                    controller: _nombreController,
                    label: 'Nombre *',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _telefonoController,
                    label: 'Teléfono *',
                    keyboardType: TextInputType.phone,
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  _buildRelacionDropdown(state.relaciones),
                  const SizedBox(height: 16),
                  _buildPaisDropdown(state.paises),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _direccionController,
                    label: 'Dirección',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _tarjetaController,
                    label: 'Tarjeta',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _notasController,
                    label: 'Notas',
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoSection() {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey.shade200,
      child: const Icon(Icons.camera_alt, size: 40, color: Colors.grey),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildRelacionDropdown(List<String> relaciones) {
    return InputDecorator(
      decoration: const InputDecoration(
        labelText: 'Relación familiar',
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _relacionSeleccionada,
          hint: const Text('Seleccione una relación'),
          items: relaciones
              .map((r) => DropdownMenuItem(value: r, child: Text(r)))
              .toList(),
          onChanged: (value) =>
              setState(() => _relacionSeleccionada = value),
        ),
      ),
    );
  }

  Widget _buildPaisDropdown(List<String> paises) {
    return InputDecorator(
      decoration: const InputDecoration(
        labelText: 'País',
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _paisSeleccionado,
          hint: const Text('Seleccione un país'),
          items: paises
              .map((p) => DropdownMenuItem(value: p, child: Text(p)))
              .toList(),
          onChanged: (value) =>
              setState(() => _paisSeleccionado = value),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) =>
      (value == null || value.isEmpty) ? 'Campo requerido' : null;

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AddContactBloc>().add(
          AddContactSubmitEvent(
            usuarioId: widget.usuarioId,
            nombre: _nombreController.text,
            telefono: _telefonoController.text,
            email: _emailController.text.isEmpty ? null : _emailController.text,
            notas: _notasController.text.isEmpty ? null : _notasController.text,
            direccion: _direccionController.text.isEmpty
                ? null
                : _direccionController.text,
            tarjeta: _tarjetaController.text.isEmpty
                ? null
                : _tarjetaController.text,
            pais: _paisSeleccionado,
            relacion: _relacionSeleccionada,
          ),
        );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _notasController.dispose();
    _direccionController.dispose();
    _tarjetaController.dispose();
    super.dispose();
  }
}

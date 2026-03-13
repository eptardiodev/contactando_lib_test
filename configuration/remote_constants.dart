class RemoteConstants {
  // HTTP status codes
  static const codeSuccess = 200;
  static const codeSuccessCreated = 201;
  static const codeSuccessAccepted = 202;
  static const codeSuccessNoContent = 204;
  static const codeBadRequest = 400;
  static const codeUnauthorized = 401;
  static const codeForbidden = 403;
  static const codeNotFound = 404;
  static const codeConflict = 409;
  static const codeHostUnable = 500;

  // Supabase table names
  static const contacto = 'contact';
  static const parentesco = 'parentesco';

  // Shared fields
  static const id = 'id';
  static const nombre = 'nombre';
  static const activo = 'active';

  // Contact fields
  static const usuario_id = 'usuario_id';
  static const telefono = 'telefono';
  static const email = 'email';
  static const foto = 'foto';
  static const fecha_creacion = 'fecha_creacion';
  static const notas = 'notas';
  static const etiquetas = 'etiquetas';
  static const direccion = 'direccion';
  static const tarjeta = 'tarjeta';
  static const pais = 'pais';

  // User fields (kept for future REST usage)
  static const user_id = 'UserId';
  static const first_name = 'FirstName';
  static const last_name = 'LastName';
  static const full_name = 'Fullname';
  static const primary_hone = 'PrimaryPhone';
  static const first_logged_on = 'FirstLoggedOn';
  static const logo_url = 'LogoUrl';
  static const url = 'url';
  static const time_zone = 'TimeZone';
  static const userName = 'UserName';
}

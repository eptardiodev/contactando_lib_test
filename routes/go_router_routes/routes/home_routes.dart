import 'package:contactando_app_gs/presentation/screen/home/home_screen.dart';
import 'package:contactando_app_gs/routes/app_routes_constants.dart';
import 'package:go_router/go_router.dart';

/// Rutas del módulo Home.
///
/// Reemplaza el archivo original en:
/// lib/routes/go_router_routes/routes/home_routes.dart
class HomeRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      name: 'home',
      path: ApplicationRoutesConstants.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ];
}

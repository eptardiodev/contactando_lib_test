import 'package:contactando_app_gs/presentation/screen/account/account_screen.dart';
import 'package:go_router/go_router.dart';

class AccountRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/account',
      builder: (context, state) =>
          AccountScreen(returnToSettings: state.uri.queryParameters['returnToSettings'] == 'true'),
    ),
  ];
}

import 'package:O2morny/features/auth/presentation/pages/login.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static List<RouteBase> routes = [
    GoRoute(path: LoginPage.route, builder: (_, __) => const LoginPage()),
  ];
}

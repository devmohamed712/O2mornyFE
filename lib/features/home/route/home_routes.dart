import 'package:O2morny/features/home/presentation/pages/home.dart';
import 'package:go_router/go_router.dart';

class HomeRoutes {
  static List<RouteBase> routes = [
    GoRoute(path: HomePage.route, builder: (_, __) => const HomePage()),
  ];
}

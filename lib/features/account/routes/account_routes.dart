import 'package:O2morny/features/account/presentation/pages/create_account.dart';
import 'package:go_router/go_router.dart';

class AccountRoutes {
  static List<RouteBase> routes = [
    GoRoute(path: CreateAccountPage.route, builder: (_, __) => const CreateAccountPage()),
  ];
}

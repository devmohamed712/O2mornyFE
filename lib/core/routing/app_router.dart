import 'package:O2morny/core/routing/auth_state.dart';
import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/account/presentation/pages/create_account.dart';
import 'package:O2morny/features/account/routes/account_routes.dart';
import 'package:O2morny/features/auth/presentation/pages/login.dart';
import 'package:O2morny/features/auth/routes/auth_routes.dart';
import 'package:O2morny/features/home/presentation/pages/home.dart';
import 'package:O2morny/features/home/route/home_routes.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  refreshListenable: getIt<AuthState>(),

  redirect: (context, state) {
    final auth = getIt<AuthState>();
    final loc = state.matchedLocation;

    if (!auth.isLoggedIn) {
      return loc == LoginPage.route ? null : LoginPage.route;
    }

    if (auth.needsProfile) {
      return loc == CreateAccountPage.route ? null : CreateAccountPage.route;
    }

    if (loc == LoginPage.route || loc == HomePage.route || loc == "/") {
      return HomePage.route;
    }

    return null;
  },

  routes: [...AuthRoutes.routes, ...AccountRoutes.routes, ...HomeRoutes.routes],
);

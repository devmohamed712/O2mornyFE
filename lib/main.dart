import 'dart:io';
import 'package:O2morny/core/network/httpOverrides.dart';
import 'package:O2morny/core/routing/app_router.dart';
import 'package:O2morny/core/routing/auth_state.dart';
import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = AppHttpOverrides();
  setupDependencies();
  await initLocalStorage();
  await getIt<AuthState>().load();
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

import 'package:finance/constants.dart';
import 'package:finance/pages/Reg_page.dart';
import 'package:finance/pages/auth_page.dart';
import 'package:finance/pages/home_page.dart';
import 'package:finance/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'Auth',
          builder: (BuildContext context, GoRouterState state) {
            return const AuthPage();
          },
          routes: <RouteBase> [
            GoRoute(
                path: 'Reg',
              builder: (BuildContext context, GoRouterState state) {
                  return const RegPage();
              }
            ),
            GoRoute(
                path: 'Home',
                builder: (BuildContext context, GoRouterState state) {
                  return const HomePage();
                }
            ),
          ]
        ),
        GoRoute(
          path: 'Home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Chat App',
      theme: appTheme,
      routerConfig: _router,
    );
  }
}

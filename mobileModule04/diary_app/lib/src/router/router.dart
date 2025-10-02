import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../pages/welcome_page.dart';
import '../pages/login_page.dart';
import '../pages/profile_page.dart';
import '../../main.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      bool isLoggedIn = ref.watch(database.authenticationProvider);
      if (isLoggedIn) {
        return '/profile';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: "welcome",
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/login',
        name: "login",
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/profile',
        name: "profile",
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
});

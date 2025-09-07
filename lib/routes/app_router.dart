import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rkm_daily/features/auth/presentation/pages/home_page.dart';
import 'package:rkm_daily/features/profile/presentation/pages/profile_page.dart';
import 'package:rkm_daily/features/updates/presentation/pages/updates_page.dart';
import 'package:rkm_daily/features/auth/presentation/pages/login_page.dart';
import 'package:rkm_daily/features/splash/presentation/pages/splash_page.dart';
import 'package:rkm_daily/features/common/widgets/app_shell.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash Route
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SplashPage()),
      ),

      // Login Route
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
      ),

      // Shell with persistent drawer/app bar
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(location: state.uri.path, child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                const MaterialPage(child: HomePage()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) =>
                const MaterialPage(child: ProfilePage()),
          ),
          GoRoute(
            path: '/updates',
            pageBuilder: (context, state) =>
                const MaterialPage(child: UpdatesPage()),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        body: Center(child: Text('Page not found: ${state.uri.path}')),
      ),
    ),
  );
}

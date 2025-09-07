import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      // 1) Prefer silent Google sign-in
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: const ['email', 'profile'],
      );
      final account = await googleSignIn.signInSilently(suppressErrors: true);

      if (account != null) {
        debugPrint('[Splash] Silent Google sign-in succeeded for: ${account.email}');
        if (!mounted) return;
        context.go('/home');
        return;
      }

      // 2) Fallback to local flag
      final prefs = await SharedPreferences.getInstance();
      final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      debugPrint('[Splash] SharedPreferences isLoggedIn=$isLoggedIn');

      // Small delay for UX
      await Future.delayed(const Duration(milliseconds: 600));

      if (!mounted) return;
      if (isLoggedIn) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    } catch (e) {
      debugPrint('[Splash] Error while checking login state: $e');
      if (!mounted) return;
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rkm_daily/features/common/widgets/app_drawer.dart';
import 'package:rkm_daily/features/common/widgets/random_background.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final String location;
  const AppShell({super.key, required this.child, required this.location});

  Color get _saffron => const Color(0xFFFF9933);
  Color get _saffronDark => const Color(0xFFCC7A29);

  @override
  Widget build(BuildContext context) {
    // Decide fixed background per route
    String fixedBg = 'assets/images/background.jpg';
    if (location == '/home') {
      fixedBg = 'assets/images/screen_background/2.jpg';
    } else if (location == '/profile') {
      fixedBg = 'assets/images/screen_background/5.jpg';
    } else if (location == '/updates') {
      fixedBg = 'assets/images/screen_background/7.jpg';
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_saffron, _saffronDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'RKM Daily',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          RandomBackground(opacity: 0.25, fixedImageAsset: fixedBg),
          // Foreground content
          child,
        ],
      ),
    );
  }
}

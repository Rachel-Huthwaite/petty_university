import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_constants.dart';
import '../theme/app_theme.dart';
import 'add_entry_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-bleed wallpaper background
          Image.asset(
            AppConstants.wallpaperHome,
            fit: BoxFit.cover,
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  // Suitcase icon, top-left -> Cases screen
                  Align(
                    alignment: Alignment.topLeft,
                    child: _CircleIconButton(
                      icon: Image.asset(AppConstants.iconCase,
                          width: 24, height: 24),
                      onTap: () => Navigator.pushNamed(context, '/cases'),
                    ),
                  ),

                  // Sign out, top-right
                  Align(
                    alignment: Alignment.topRight,
                    child: _CircleIconButton(
                      icon: const Icon(Icons.logout,
                          color: Colors.white, size: 22),
                      onTap: () => AuthService().signOut(),
                    ),
                  ),

                  // Main CTA, bottom -> new open entry
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: _TakeItToButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/entry',
                          arguments: const AddEntryScreenArgs(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: icon,
        ),
      ),
    );
  }
}

class _TakeItToButton extends StatelessWidget {
  final VoidCallback onTap;

  const _TakeItToButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.black.withOpacity(0.75),
              Colors.black.withOpacity(0.15),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('TAKE IT TO', style: AppTheme.takeItTo),
            Text('PETTY UNIVERSITY', style: AppTheme.pettyUniversityTitle),
          ],
        ),
      ),
    );
  }
}

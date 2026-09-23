import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_constants.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/pill_button.dart';

/// The login gate — shown by AuthGate when there's no signed-in user.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSignUp = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Enter an email and password.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final error = _isSignUp
        ? await _authService.signUp(email: email, password: password)
        : await _authService.signIn(email: email, password: password);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _errorMessage = error;
    });
    // On success, AuthGate's StreamBuilder picks up the auth state change
    // automatically and swaps to HomeScreen — no navigation call needed here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppConstants.wallpaperHome, fit: BoxFit.cover),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: GlassContainer(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PETTY UNIVERSITY', style: AppTheme.pettyUniversityTitle),
                      const SizedBox(height: 4),
                      Text(
                        _isSignUp ? 'Create an account to start.' : 'Sign in to keep venting.',
                        style: AppTheme.screenDescription,
                      ),
                      const SizedBox(height: 24),

                      _AuthTextField(
                        controller: _emailController,
                        hint: 'Email',
                        obscure: false,
                      ),
                      const SizedBox(height: 12),
                      _AuthTextField(
                        controller: _passwordController,
                        hint: 'Password',
                        obscure: true,
                      ),

                      if (_errorMessage != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _errorMessage!,
                          style: AppTheme.unpackSubtext.copyWith(color: Colors.redAccent),
                        ),
                      ],

                      const SizedBox(height: 24),

                      Center(
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : PillButton(
                                label: _isSignUp ? 'Sign Up' : 'Sign In',
                                labelStyle: AppTheme.unpackButtonLabel,
                                color: AppTheme.accentGreen,
                                width: 160,
                                onTap: _submit,
                              ),
                      ),
                      const SizedBox(height: 16),

                      Center(
                        child: TextButton(
                          onPressed: _isLoading
                              ? null
                              : () => setState(() {
                                    _isSignUp = !_isSignUp;
                                    _errorMessage = null;
                                  }),
                          child: Text(
                            _isSignUp
                                ? 'Already have an account? Sign in'
                                : "Don't have an account? Sign up",
                            style: AppTheme.otherFieldHint,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;

  const _AuthTextField({
    required this.controller,
    required this.hint,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: AppTheme.userInputText.copyWith(fontSize: 14),
        cursorColor: AppTheme.textPrimary,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: AppTheme.entryHintText.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}

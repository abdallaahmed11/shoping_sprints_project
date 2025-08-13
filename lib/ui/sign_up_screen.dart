import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose(); _email.dispose(); _pass.dispose(); _confirm.dispose();
    super.dispose();
  }

  Future<void> _goHomeWithFade(BuildContext context) async {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) => const HomeScreen(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(t.signUp)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(labelText: t.fullName, border: const OutlineInputBorder()),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return t.pleaseEnterValue;
                      if (!RegExp(r'^[A-Z]').hasMatch(v.trim())) return t.nameMustStartUpper;
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(labelText: t.email, border: const OutlineInputBorder()),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return t.pleaseEnterValue;
                      if (!v.contains('@')) return t.emailInvalid;
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _pass,
                    obscureText: true,
                    decoration: InputDecoration(labelText: t.password, border: const OutlineInputBorder()),
                    validator: (v) {
                      if (v == null || v.isEmpty) return t.pleaseEnterValue;
                      if (v.length < 6) return t.passwordMin;
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _confirm,
                    obscureText: true,
                    decoration: InputDecoration(labelText: t.confirmPassword, border: const OutlineInputBorder()),
                    validator: (v) {
                      if (v != _pass.text) return t.passwordsNotMatch;
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Icon(Icons.check_circle, color: Colors.teal, size: 40),
                          content: Text(t.signupSuccess, textAlign: TextAlign.center),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(t.close),
                            ),
                          ],
                        ),
                      );
                      await _goHomeWithFade(context);
                    },
                    child: Text(t.signUp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

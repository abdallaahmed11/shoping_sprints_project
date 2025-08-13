import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../main.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.welcomeTitle),
        actions: [
          IconButton(
            tooltip: 'Language',
            onPressed: () => LocaleController.instance.toggle(),
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                t.welcomeHeadline,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'images/imageph1.jpeg', // انت عندك assets: - images/
                      width: 140, height: 140, fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://picsum.photos/200/200',
                      width: 140, height: 140, fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, SignInScreen.routeName),
                    child: Text(t.signIn),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, SignUpScreen.routeName),
                    child: Text(t.signUp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

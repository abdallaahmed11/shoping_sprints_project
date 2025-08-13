import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'ui/welcome_screen.dart';
import 'ui/sign_in_screen.dart';
import 'ui/sign_up_screen.dart';
import 'ui/home_screen.dart';

// كنترولر بسيط للسويتش بتاع اللغة من أي شاشة
class LocaleController extends ChangeNotifier {
  LocaleController._();
  static final instance = LocaleController._();

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  void toggle() {
    _locale = _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }

  void setLocale(Locale l) {
    _locale = l;
    notifyListeners();
  }
}

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final localeCtrl = LocaleController.instance;

    // AnimatedBuilder علشان أي تغيير في اللغة يعيد بناء الماتيريال أب
    return AnimatedBuilder(
      animation: localeCtrl,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: localeCtrl.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          // لو الجهاز عربي خليه يبدأ عربي
          localeResolutionCallback: (deviceLocale, supported) {
            if (deviceLocale == null) return localeCtrl.locale;
            for (final l in supported) {
              if (l.languageCode == deviceLocale.languageCode) {
                return l;
              }
            }
            return localeCtrl.locale;
          },
          theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'Suwannaphum', // لو مش موجود هياخد الديفولت
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
          ),
          routes: {
            WelcomeScreen.routeName: (_) => const WelcomeScreen(),
            SignInScreen.routeName: (_) => const SignInScreen(),
            SignUpScreen.routeName: (_) => const SignUpScreen(),
            HomeScreen.routeName: (_) => const HomeScreen(),
          },
          initialRoute: WelcomeScreen.routeName,
        );
      },
    );
  }
}

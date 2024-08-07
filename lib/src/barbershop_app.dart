import 'package:app_barbershop/src/core/ui/babershop_theme.dart';
import 'package:app_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:app_barbershop/src/features/splash/splash_page.dart';
import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';

import 'core/ui/widgets/barbershop_loader.dart';
import 'features/auth/login/login_page.dart';
import 'features/auth/register/barbershop/barbershop_register_page.dart';
import 'features/auth/register/user/user_register_page.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
        customLoader: const BarbershopLoader(),
        builder: (asyncNavigatorObserver) {
          return MaterialApp(
            title: 'BarberShop',
            theme: BabershopTheme.themeData,
            navigatorObservers: [asyncNavigatorObserver],
            navigatorKey: BarbershopNavGlobalKey.instance.navKey,
            routes: {
              '/': (_) => const SplashPage(),
              '/auth/login': (_) => const LoginPage(),
              '/auth/register/user': (_) => const UserRegisterPage(),
              '/auth/register/barbershop': (_) => const BarbershopRegisterPage(),
              '/home/adm': (_) => const Text('ADM'),
              '/home/employee': (_) => const Text('Employee'),
            },
          );
        });
  }
}

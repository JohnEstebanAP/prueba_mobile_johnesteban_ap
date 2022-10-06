import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/providers/ui_provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/screens/screens.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/auth_service.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/comics_service.dart';
import 'package:prueba_mobile_johnesteban_ap/src/themes/theme_light.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ComicsService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'prueba Mobile',
      initialRoute: 'checking',
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetailsComicScreen(),
        'register': (_) => const RegisterScreen(),
        'checking': (_) => const CheckAutnScreen(),
      },
      theme: ThemeDark.themeDark,
    );
  }
}

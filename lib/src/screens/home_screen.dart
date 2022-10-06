import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/comics_service.dart';
import '../providers/ui_provider.dart';
import '../services/auth_service.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel Comics'),
        leading: IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    //option seleted
    int currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return const ComicsScreen();
      case 1:
        return const FavoritesScreen();
      default:
        return const ComicsScreen();
    }
  }
}

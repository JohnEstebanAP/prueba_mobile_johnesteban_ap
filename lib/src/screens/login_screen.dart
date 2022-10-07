import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/themes/theme_light.dart';
import '../providers/login_provider.dart';
import '../services/auth_service.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeDark.colorDard,
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 250),
              CardDataUser(title: 'Login', type: 'login'),
              SizedBox(height: 50),
              TextButtonChangePage(
                  title: 'Create a new account', nameNextPage: 'register'),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}

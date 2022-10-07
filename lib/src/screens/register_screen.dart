import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/providers/login_provider.dart';
import '../themes/theme_light.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeDark.colorDard,
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 250),
              CardDataUser(title: 'Create an account', type: 'register'),
              SizedBox(height: 50),
              TextButtonChangePage(
                  nameNextPage: 'login', title: 'Already have an account?'),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}

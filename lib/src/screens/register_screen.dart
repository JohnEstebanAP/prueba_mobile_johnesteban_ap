import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/providers/login_provider.dart';
import '../services/auth_service.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 250),
              CardDataUser(title: 'Crear cuenta', type: 'register'),
              SizedBox(height: 50),
              TextButtonChangePage(
                  nameNextPage: 'login', title: 'Ya tienes una cuenta?'),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}

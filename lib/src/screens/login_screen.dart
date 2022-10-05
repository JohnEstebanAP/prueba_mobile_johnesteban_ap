import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_provider.dart';
import '../services/auth_service.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 250),
              CardDataUser(title: 'Ingreso', type: 'login'),
              SizedBox(height: 50),
              TextButtonChangePage(
                  title: 'Crear una nueva cuenta', nameNextPage: 'register'),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}

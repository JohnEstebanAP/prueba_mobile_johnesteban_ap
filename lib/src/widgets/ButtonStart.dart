import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/widgets/widgets.dart';

import '../providers/login_provider.dart';
import '../services/auth_service.dart';

class ButtonStart extends StatelessWidget {
  const ButtonStart({
    Key? key,
    required this.loginForm,
  }) : super(key: key);

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: loginForm.isLoading
          ? null
          : () async {
              //we hide the keyboard, taking the focus off it
              FocusScope.of(context).unfocus();

              if (!loginForm.isValidForm()) return;

              loginForm.isLoading = true;

              if (loginForm.type == 'login') {
                onPressedlogin(context);
              } else {
                onPressedRegister(context);
              }

              loginForm.isLoading = false;
            },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Colors.deepPurple,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(loginForm.isLoading ? 'Espere' : 'Ingresar',
            style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  onPressedRegister(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final String? errorMessage =
        await authService.createUser(loginForm.email, loginForm.password);

    if (errorMessage == null) {
      ToastCuston.LikeToast("Felicidades por su nueva cuenta :)");
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      //Todo: mostrar error en pantalla
      ToastCuston.ErrorToast(errorMessage);
    }
  }

  onPressedlogin(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final String? errorMessage =
        await authService.login(loginForm.email, loginForm.password);

    if (errorMessage == null) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      //Todo: mostrar error en pantalla
      ToastCuston.ErrorToast('El Correo no es valido.');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/themes/theme_light.dart';
import 'package:prueba_mobile_johnesteban_ap/src/widgets/widgets.dart';

import '../providers/login_provider.dart';
import '../services/auth_service.dart';
import '../ui/input_decorations.dart';

class CardDataUser extends StatelessWidget {
  final String title;
  final String type;

  const CardDataUser({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          _TitleCard(title: title),
          ChangeNotifierProvider(
            create: (_) => LoginFormProvider(),
            child: _LoginForm(
              type: type,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 30),
      child: Text(
        title,
        style: const TextStyle(color: ThemeDark.colorDard, fontSize: 35),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    loginForm.type = type;

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        //Todo: matener la referencia al Key
        child: Column(
          children: [
            _TextFromFieldEmail(loginForm: loginForm),
            const SizedBox(height: 30),
            _TextFromFielPassword(loginForm: loginForm),
            const SizedBox(height: 30),
            ButtonStart(loginForm: loginForm),
          ],
        ),
      ),
    );
  }
}

class _TextFromFielPassword extends StatelessWidget {
  const _TextFromFielPassword({
    Key? key,
    required this.loginForm,
  }) : super(key: key);

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: ThemeDark.colorDard),
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Contraseña',
        hintText: '***********',
        prefixIcon: Icons.lock_outline,
      ),
      onChanged: (value) => {loginForm.password = value},
      validator: (value) {
        return (value != null && value.length >= 6)
            ? null
            : 'La contraseña debe de ser de 6 caracteres.';
      },
    );
  }
}

class _TextFromFieldEmail extends StatelessWidget {
  const _TextFromFieldEmail({
    Key? key,
    required this.loginForm,
  }) : super(key: key);

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: ThemeDark.colorDard),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecorations.authInputDecoration(
          labelText: 'Correo electronico',
          hintText: 'john.alvarez@sofka.com.co',
          prefixIcon: Icons.alternate_email),
      onChanged: (value) => {loginForm.email = value},
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = RegExp(pattern);

        return regExp.hasMatch(value ?? '')
            ? null
            : 'El valor ingresado no luce como un correo';
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'screens.dart';

class CheckAutnScreen extends StatelessWidget {
  const CheckAutnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToken(),
            builder: (BuildContext contex, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return Column(
                  children: const <Widget>[
                    Text('Espere'),
                    CircularProgressIndicator()
                  ],
                );
              }

              if (snapshot.data == '') {
                Future.microtask(() {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      //el pageBuirder resive lao 3 animaciones en este caso no queremos animaciones
                      pageBuilder: (_, __, ___) => const LoginScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                });
              } else {
                Future.microtask(() {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      //el pageBuirder resive lao 3 animaciones en este caso no queremos animaciones
                      pageBuilder: (_, __, ___) => const HomeScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                });
              }

              return Container();
            }),
      ),
    );
  }
}

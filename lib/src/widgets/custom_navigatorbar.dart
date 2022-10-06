import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/themes/theme_light.dart';

import '../providers/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: true);
    int currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: ThemeLight.colorPrimary,
      unselectedItemColor: Colors.white38,
      //unselectedItemColor: Color.fromRGBO(116, 117, 152, 1),
      //backgroundColor: Color.fromRGBO(55, 57, 84, 1),
      backgroundColor: ThemeLight.colorDard,
      currentIndex: currentIndex,
      elevation: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: 'Comics'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined), label: 'Favorites'),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/services.dart';
import 'package:prueba_mobile_johnesteban_ap/src/widgets/widgets.dart';
import '../models/models.dart';
import 'screens.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesComicsServices =
        Provider.of<FavoritesComicsService>(context);

    if (favoritesComicsServices.isLoding) return const LoadingScreen();

    return ComicSliderVertical(
      comic: favoritesComicsServices.comics,
      title: 'List of favorite comics',
      onNextPage: () => {},
    );
  }
}

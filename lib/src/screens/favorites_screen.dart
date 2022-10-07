import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/services.dart';
import 'package:prueba_mobile_johnesteban_ap/src/widgets/widgets.dart';
import '../models/models.dart';
import 'screens.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritesComicsServices =
        Provider.of<FavoritesComicsService>(context);

    if (favoritesComicsServices.refres) {
      favoritesComicsServices.loadFavorites();
      setState(() {});
    }

    if (favoritesComicsServices.isLoding) return const LoadingScreen();

    return ComicSliderVertical(
      comic: favoritesComicsServices.comics,
      title: 'List of favorite comics',
      onNextPage: () => {},
    );
  }
}

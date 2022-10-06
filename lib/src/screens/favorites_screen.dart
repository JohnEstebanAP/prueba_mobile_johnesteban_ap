import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/widgets/widgets.dart';

import '../services/comics_service.dart';
import 'screens.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comicsService = Provider.of<ComicsService>(context);

    if (comicsService.isLoding) return const LoadingScreen();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Targetas principales
          CardSwiper(comics: comicsService.comics),
          //Slider de Comics
          ComicSlider(
            comic: comicsService.allComics,
            title: 'Complete List',
            onNextPage: () => comicsService.getnextComics(),
          ),
        ],
      ),
    );
  }
}

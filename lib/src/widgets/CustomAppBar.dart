import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/services.dart';

import '../models/comic.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../themes/theme_light.dart';

class CustomAppBar extends StatelessWidget {
  final Comic comic;

  const CustomAppBar({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final favoritesComics = Provider.of<FavoritesComicsService>(context);

    Icon icon = const Icon(Icons.favorite);
    if (favoritesComics.favoriteComic.comics.contains(comic.id)) {
      icon = const Icon(Icons.favorite, color: ThemeDark.colorPrimary);
      print('Si lo contiene');
    }
    print('No lo contiene');

    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () {
            favoritesComics.favoriteComic.comics.add(comic.id!);
            favoritesComics.createProduct();
          },
          icon: icon,
        ),
        IconButton(
          onPressed: () {
            Share.share(comic!.urls!.first!.url ??
                'https://www.marvel.com/comics?&options%5Boffset%5D=0&totalcount=12');
          },
          icon: const Icon(Icons.share_outlined),
        ),
      ],
      backgroundColor: ThemeDark.colorPrimary,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.black26,
          child: Text(
            comic.title ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(
              '${comic.thumbnail!.path}/landscape_incredible.${comic.thumbnail!.extension}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

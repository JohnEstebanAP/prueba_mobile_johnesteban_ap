import 'package:flutter/material.dart';
import 'package:prueba_mobile_johnesteban_ap/src/themes/theme_light.dart';

import '../models/comic.dart';

class DetailsComicScreen extends StatelessWidget {
  const DetailsComicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Comic comic = ModalRoute.of(context)!.settings.arguments as Comic;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(comic: comic),
          /*SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(comic: comic),
              _OverView(comic: comic),
              //CastingCards(comic.id)
            ]),
          ),*/
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Comic comic;

  const _CustomAppBar({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      backgroundColor: ThemeLight.colorPrimary,
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
          color: Colors.black12,
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

class _PosterAndTitle extends StatelessWidget {
  final Comic comic;

  const _PosterAndTitle({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: comic.id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(
                    '${comic.thumbnail!.path}/portrait_fantastic.${comic.thumbnail!.extension}'),
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comic.title ?? '',
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    // Todo: revisar
                    //Text(
                    //  comic.voteAverage.toString(),
                    //  style: textTheme.caption, )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final Comic comic;

  const _OverView({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        comic.description,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

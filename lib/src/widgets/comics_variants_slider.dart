import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/comic.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/comics_service.dart';

class ComicVariantsSlider extends StatelessWidget {
  final String? title;
  final Comic comic;
  final Function onNextPage;

  const ComicVariantsSlider(
      {super.key, required this.comic, this.title, required this.onNextPage});

  @override
  Widget build(BuildContext context) {
    final comicsServise = Provider.of<ComicsService>(context, listen: false);

    return FutureBuilder(
        future: comicsServise.getVariantsFromComic(comic),
        builder: (_, AsyncSnapshot<List<Comic>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: BoxConstraints(maxWidth: 150),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          }

          final List<Comic> comics = snapshot.data!;

          return Container(
            width: double.infinity,
            height: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(title!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: comics.length,
                    itemBuilder: (_, int index) =>
                        _ComicPoster(comics[index], (comics[index].id! + 200000)),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _ComicPoster extends StatelessWidget {
  final Comic comic;
  final int comicId;

  const _ComicPoster(this.comic, this.comicId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    comic.id = comicId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: comic),
            child: Hero(
              tag: comic.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(
                      '${comic.thumbnail!.path}/portrait_fantastic.${comic.thumbnail!.extension}'),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            comic.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

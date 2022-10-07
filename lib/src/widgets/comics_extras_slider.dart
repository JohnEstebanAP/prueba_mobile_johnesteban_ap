import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/comic.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/extras.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/comics_service.dart';

class ComicsExtrasSlider extends StatelessWidget {
  final String? title;
  final Comic comic;
  final Function onNextPage;

  const ComicsExtrasSlider(
      {super.key, required this.comic, this.title, required this.onNextPage});

  @override
  Widget build(BuildContext context) {
    final comicsServise = Provider.of<ComicsService>(context, listen: false);
    //comicsServise.getCreatorFromComic(comic);
    return FutureBuilder(
        future: (title! == 'Creators')
            ? comicsServise.getCreatorFromComic(comic)
            : comicsServise.getVariantsFromComic(comic),
        builder: (_, AsyncSnapshot<List<Extras>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: BoxConstraints(maxWidth: 150),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          }

          final List<Extras> extras = snapshot.data!;

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
                    itemCount: extras.length,
                    itemBuilder: (_, int index) => _ComicPoster(
                        extras[index], (extras[index].id! + 200000)),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _ComicPoster extends StatelessWidget {
  final Extras extras;
  final int extrasId;

  const _ComicPoster(this.extras, this.extrasId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    extras.id = extrasId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: extras),
            child: Hero(
              tag: extras.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  //  (extras.image == '')
                  image: NetworkImage(extras.image!),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            extras.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/comic.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/extras.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/character_service.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/creator_service.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/stories_service.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/variants_service.dart';

class ComicsExtrasSlider extends StatelessWidget {
  final String? title;
  final Comic comic;

  const ComicsExtrasSlider({super.key, required this.comic, this.title});

  @override
  Widget build(BuildContext context) {
    final storiesServices = Provider.of<StoriesService>(context, listen: false);
    final characterServices = Provider.of<CharacterService>(context, listen: false);
    final creatorServices = Provider.of<CreatorService>(context, listen: false);
    final variantsServices = Provider.of<VariantsService>(context, listen: false);

    return FutureBuilder(
        future: (title! == 'Creators')
            ? creatorServices.getCreatorFromComic(comic)
            : (title! == 'Characters')
                ? characterServices.getCharactersFromComic(comic)
                : (title == 'Stories')
                    ? storiesServices.getStoriesFromComic(comic)
                    : variantsServices.getVariantsFromComic(comic),
        builder: (_, AsyncSnapshot<List<Extras>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          }

          final List<Extras> extras = snapshot.data!;

          return SizedBox(
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
          Hero(
            tag: extras.id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(extras.image!),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
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

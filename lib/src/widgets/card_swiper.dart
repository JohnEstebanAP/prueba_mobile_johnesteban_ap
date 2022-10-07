import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/comic.dart';

class CardSwiper extends StatelessWidget {
  final List<Comic> comics;

  const CardSwiper({Key? key, required this.comics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (comics.isEmpty) {
      return SizedBox(
          width: double.infinity,
          height: size.height * 0.5,
          child: const Center(
            child: CircularProgressIndicator(),
          ));
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: comics.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, int index) {
          final Comic comic = comics[index];

          comic.idTap = '${comic.id!}-1';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: comic),
            child: Hero(
              tag: comic.idTap!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(
                      '${comic.thumbnail!.path}/portrait_uncanny.${comic.thumbnail!.extension}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

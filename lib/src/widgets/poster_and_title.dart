import 'package:flutter/material.dart';

import '../models/comic.dart';

class PosterAndTitle extends StatelessWidget {
  final Comic comic;

  const PosterAndTitle({Key? key, required this.comic}) : super(key: key);

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
            tag: comic.idTap!,
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
                _InfoCuston(textTheme, Icons.monetization_on,
                    'Price: \$${comic.prices?[0].price ?? 0} USD'),
                _InfoCuston(textTheme, Icons.insert_drive_file_sharp,
                    'Pages Count: ${comic.pageCount}.'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _InfoCuston(TextTheme textTheme, IconData icon, String text) {
    return Row(
      children: [
        (comic.prices?[0].price != 0)
            ? Icon(
                icon,
                size: 15,
                color: Colors.grey,
              )
            : const SizedBox(),
        (comic.prices?[0].price != 0)
            ? const SizedBox(width: 5)
            : const SizedBox(),
        (comic.prices?[0].price != 0)
            ? Text(
                text,
                style: textTheme.caption,
              )
            : const SizedBox(),
      ],
    );
  }
}

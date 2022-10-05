import '../models/comic.dart';
import 'package:flutter/material.dart';

import '../themes/theme_light.dart';

class CustomAppBar extends StatelessWidget {
  final Comic comic;

  const CustomAppBar({Key? key, required this.comic}) : super(key: key);

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

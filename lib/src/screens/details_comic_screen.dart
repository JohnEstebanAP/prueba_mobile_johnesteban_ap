import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/themes/theme_light.dart';
import 'package:prueba_mobile_johnesteban_ap/src/widgets/widgets.dart';

import '../models/comic.dart';
import '../services/comics_service.dart';

class DetailsComicScreen extends StatelessWidget {
  const DetailsComicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Comic comic = ModalRoute.of(context)!.settings.arguments as Comic;

    return Scaffold(
      backgroundColor: ThemeDark.colorDard,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(comic: comic),
          SliverList(
            delegate: SliverChildListDelegate([
              PosterAndTitle(comic: comic),
              _Description(comic: comic),
              (comic.characters!.items!.isNotEmpty)
                  ? ComicsExtrasSlider(title: 'Characters', comic: comic)
                  : const SizedBox(),
              (comic.variants!.isNotEmpty)
                  ? ComicsExtrasSlider(title: 'Variants', comic: comic)
                  : const SizedBox(),
              (comic.stories!.items!.isNotEmpty)
                  ? ComicsExtrasSlider(title: 'Stories', comic: comic)
                  : const SizedBox(),
              (comic.creators!.items!.isNotEmpty)
                  ? ComicsExtrasSlider(title: 'Creators', comic: comic)
                  : const SizedBox(),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final Comic comic;

  const _Description({Key? key, required this.comic}) : super(key: key);

  final TextStyle themeTitle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Table2SerialNumber(size, 0.8),
            _Table2byDescritionCustom(size, 0.8, 'Published: ', comic.getDates),
            _Table2byDescritionCustom(
                size, 0.8, 'Last modification: ', comic.getModified),
            _Table2byDescritionCustom(size, 0.8, 'Format: ', comic.format!),
            _Table2byDescritionCustom(
                size, 0.8, 'Series: ', comic.series!.name!),
            _description(context),
            _Table2byDescritionCustom(size, 0.8, 'ISBN: ', comic.isbn!),
            _Table2byDescritionCustom(size, 0.8, 'Barcode UPC: ', comic.upc!)
          ],
        ));
  }

  Container _description(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Text(
        comic.description ?? '',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Container _Table2SerialNumber(Size size, double porcent) {
    return Container(
      width: size.width * porcent,
      child: Table(children: [
        TableRow(
          children: [
            Text(
              'Serial number: ',
              style: themeTitle,
            ),
            Text(comic.issueNumber.toString() == '0'
                ? 'Collection'
                : comic.issueNumber.toString()),
          ],
        ),
      ]),
    );
  }

  Container _Table2byDescritionCustom(
      Size size, double porcent, String text1, String text2) {
    return Container(
      width: size.width * porcent,
      child: Table(children: [
        TableRow(
          children: [
            (text2.isNotEmpty)
                ? Text(text1, style: themeTitle)
                : const SizedBox(),
            (text2.isNotEmpty) ? Text(text2) : const SizedBox(),
          ],
        ),
      ]),
    );
  }
}

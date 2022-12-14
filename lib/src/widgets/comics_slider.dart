import 'package:flutter/material.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/comic.dart';

class ComicSlider extends StatefulWidget {
  final String? title;
  final List<Comic> comic;
  final Function onNextPage;

  const ComicSlider(
      {super.key, required this.comic, this.title, required this.onNextPage});

  @override
  State<ComicSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<ComicSlider> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 400) {
        print('scroll ${scrollController.position.maxScrollExtent}');
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.title!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.comic.length,
              itemBuilder: (_, int index) => _ComicPoster(
                  widget.comic[index], (widget.comic[index].id! + 200000)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComicPoster extends StatelessWidget {
  final Comic comic;
  final int comicId;

  const _ComicPoster(this.comic, this.comicId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    comic.idTap = '${comic.id!}-2';

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
              tag: comic.idTap!,
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

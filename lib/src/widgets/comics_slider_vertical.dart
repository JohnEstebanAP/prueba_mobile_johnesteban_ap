import 'package:flutter/material.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/comic.dart';

class ComicSliderVertical extends StatefulWidget {
  final String? title;
  final List<Comic> comic;
  final Function onNextPage;

  const ComicSliderVertical(
      {super.key, required this.comic, this.title, required this.onNextPage});

  @override
  State<ComicSliderVertical> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<ComicSliderVertical> {
  final ScrollController scrollController = ScrollController();

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
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          if (widget.title != null)
            Container(
              alignment: Alignment.center,
              child: Text(widget.title!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              scrollDirection: Axis.vertical,
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
    comic.idTap = '$comicId - 3';

    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 1,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                      '${comic.thumbnail!.path}/portrait_uncanny.${comic.thumbnail!.extension}'),
                  width: 300,
                  height: 450,
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

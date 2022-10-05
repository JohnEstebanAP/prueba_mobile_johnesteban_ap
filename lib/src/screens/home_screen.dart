import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mobile_johnesteban_ap/src/services/comics_service.dart';
import '../services/auth_service.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comicsService = Provider.of<ComicsService>(context);
    final authService = Provider.of<AuthService>(context);

    if (comicsService.isLoding) return const LoadingScreen();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Marvel Comics'),
          leading: IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Targetas principales
              CardSwiper(comics: comicsService.comics),
              //Slider de Comics
              ComicSlider(
                comic: comicsService.allComics,
                title: 'Complete List',
                onNextPage: () => comicsService.getnextComics(),
              ),
            ],
          ),
        )
        /*
      ListView.builder(
        itemCount: comicsService.comics.length,
        itemBuilder: (_, int index) => GestureDetector(
          onTap: () {
            comicsService.selectedComic = comicsService.comics[index].copy();
            //Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(
            product: productsService.products[index],
          ),
        ),
      ),*/
        );
  }
}

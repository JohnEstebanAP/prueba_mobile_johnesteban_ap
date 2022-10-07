import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_mobile_johnesteban_ap/src/services/get_favorites_services.dart';

class FavoritesComicsService extends ChangeNotifier {
  GetFavoritesService getFavoritesService = GetFavoritesService();

  final String _baseUrl = 'prueba-mobile-flutter-default-rtdb.firebaseio.com';

  FavoritesComics favoriteComic = FavoritesComics(comics: [], user: '123');

  List<FavoritesComics> favoritesComics = [];

  late Comic selectedProduct;

  final storage = const FlutterSecureStorage();

  List<Comic> comics = [];

  bool isLoding = true;
  bool isSaving = false;

  FavoritesComicsService() {
    loadProducts();
  }

  Future<List<Comic>> loadProducts() async {
    isLoding = true;
    notifyListeners();

    var userId = await storage.read(key: 'token') ?? '';
    final url =
        Uri.https(_baseUrl, 'FavoritesComics/$userId.json', {'auth': userId});

    final resp = await http.get(url);

    final Map<String, dynamic> favoritesComicsMap = json.decode(resp.body);

    favoriteComic = FavoritesComics.fromMap(favoritesComicsMap);

    comics = await getFavoritesService.getFavoritesComic(favoriteComic.comics);

    isLoding = false;
    notifyListeners();
    return comics;
  }

  Future<String> createFavorite() async {
    String userId = await storage.read(key: 'token') ?? '';
    favoriteComic.user = userId;
    final url =
        Uri.https(_baseUrl, 'FavoritesComics/$userId.json', {'auth': userId});

    final resp = await http.put(url, body: favoriteComic.toJson());
    final decodeData = json.decode(resp.body);

    //Actualizar la Lista de productos
    favoritesComics.add(favoriteComic);

    notifyListeners();
    return favoriteComic.comics.toString();
  }

  Future<String> deleteFavorite(int idfavoriteDelete) async {
    List<int> favorites = [];

    favoriteComic.comics.forEach((favorite) {
      if (idfavoriteDelete != favorite) {
        favorites.add(favorite);
      }
    });

    favoriteComic.comics = favorites;

    String userId = await storage.read(key: 'token') ?? '';
    favoriteComic.user = userId;
    final url =
        Uri.https(_baseUrl, 'FavoritesComics/$userId.json', {'auth': userId});

    final resp = await http.put(url, body: favoriteComic.toJson());
    final decodeData = json.decode(resp.body);

    //Actualizar la Lista de productos
    favoritesComics.add(favoriteComic);

    notifyListeners();
    return favoriteComic.comics.toString();
  }
}

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
  List<Comic> comics = [];

  final storage = const FlutterSecureStorage();

  bool isLoding = true;
  bool refres = false;

  FavoritesComicsService() {
    loadFavorites();
  }

  Future<List<Comic>> loadFavorites() async {
    isLoding = true;
    notifyListeners();

    favoriteComic.comics = [];

    var userId = await storage.read(key: 'token') ?? '';
    final url =
        Uri.https(_baseUrl, 'FavoritesComics/$userId.json', {'auth': userId});

    final resp = await http.get(url);

    final Map<String, dynamic> favoritesComicsMap = json.decode(resp.body);

    if (favoritesComicsMap['comics'] == null) {
      isLoding = false;
      notifyListeners();
      return comics;
    }

    favoriteComic = FavoritesComics.fromMap(favoritesComicsMap);

    //if (favoriteComic.comics.length != comics.length) {
    comics = [];
    comics = await getFavoritesService.getFavoritesComic(favoriteComic.comics);
    //}
    print('comics: ${comics.length}');
    print('fa: ${favoriteComic.comics.length}');

    refres = false;
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
    favoriteComic = FavoritesComics.fromMap(decodeData);

    refres = true;
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
    favoriteComic = FavoritesComics.fromMap(decodeData);

    refres = true;
    notifyListeners();
    return favoriteComic.comics.toString();
  }
}

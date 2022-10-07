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

    print('favaritos: ${favoriteComic.comics}');
    isLoding = false;
    notifyListeners();
    return comics;
  }




  Future<String> createProduct() async {
    String userId = await storage.read(key: 'token') ?? '';
    favoriteComic.user = userId;
    final url =
        Uri.https(_baseUrl, 'FavoritesComics/$userId.json', {'auth': userId});

    final resp = await http.put(url, body: favoriteComic.toJson());
    final decodeData = json.decode(resp.body);
    print('Respuesta $decodeData');

    //Actualizar la Lista de productos
    favoritesComics.add(favoriteComic);

    return favoriteComic.comics.toString();
  }
/*
  void updateSelectedProductImage(String path) {
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dnsgy2ht5/image/upload?upload_preset=cqa69qhx');

    //creamos la peticion
    final imageUploadRequest = http.MultipartRequest('POST', url);
    //ajuntamos el archivo
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    //agegamos el file a la peticion
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    //lo colocamos en null para indicar que lla lo subimos y no nesecitamo esa propiedad
    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }

 */
}

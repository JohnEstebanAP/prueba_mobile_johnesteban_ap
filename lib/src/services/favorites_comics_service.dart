import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_mobile_johnesteban_ap/src/services/get_favorites_services.dart';

class FavoritesComicsService extends ChangeNotifier {
  GetFavoritesService getFavoritesService = GetFavoritesService();

  final String _baseUrl = 'prueba-mobile-flutter-default-rtdb.firebaseio.com';

  FavoritesComics favoriteComis = FavoritesComics(comics: [], user: '123');
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

    favoriteComis = FavoritesComics.fromMap(favoritesComicsMap);

    //tempProduct.id = key;

    comics = await getFavoritesService.getFavoritesComic(favoriteComis.comics);

    isLoding = false;
    notifyListeners();
    return comics;
  }
/*
  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //es necesario crear
      await createProduct(product);
    } else {
      //Actualizar
      await updateProducto(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProducto(Product product) async {
    final url = Uri.https(_baseUrl, 'product/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodeData = resp.body;
    //print(decodeData);

    //Actualizar la Lista de productos
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id ?? '';
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'product/${product.id}.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: product.toJson());
    final decodeData = json.decode(resp.body);
    //print(decodeData);

    //Actualizar la Lista de productos
    product.id = decodeData['name'];
    products.add(product);

    return product.id ?? '';
  }

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

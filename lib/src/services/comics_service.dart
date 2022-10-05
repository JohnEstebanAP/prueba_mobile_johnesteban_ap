import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/comic.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_mobile_johnesteban_ap/src/widgets/toast.dart';

class ComicsService extends ChangeNotifier {
  final String _baseUrl = 'gateway.marvel.com';
  final String _bodyUrl = '/v1/public/comics';
  final String _apikey = 'ab172c13e5eadcee42116f385af2efc5';
  final String _hash = 'c2d346f9a5e7e323b16c545d6a5f6e15';
  final String _ts = '1';
  int _curretpage = 0;

  List<Comic> comics = [];
  List<Comic> allComics = [];

  //final List<Comic> comics = [];
  late Comic selectedComic;

  //final storage = const FlutterSecureStorage();

  bool isLoding = true;
  bool isLodingSlider = false;
  bool isSaving = false;

  ComicsService() {
    _curretpage = 0;
    loadComics();
    getnextComics();
  }

  Future<String> _getJsonData(String endPoint) async {
    final url = Uri.http(
      _baseUrl,
      endPoint,
      {
        'apikey': _apikey,
        'ts': _ts,
        'hash': _hash,
        'offset': _curretpage.toString()
      },
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      ToastCuston.ErrorToast(
          'Request failed with status: ${response.statusCode}.');
      return '';
    }
  }

  Future<List<Comic>> loadComics() async {
    isLoding = true;
    notifyListeners();

    final response = await _getJsonData(_bodyUrl);

    final Map<String, dynamic> comicMap = json.decode(response)['data'];

    comicMap['results'].forEach((value) {
      final Comic tempComic = Comic.fromMap(value);
      comics.add(tempComic);
    });

    isLoding = false;

    notifyListeners();
    return comics;
  }

  getnextComics() async {
    if (isLodingSlider == false) {
      isLodingSlider = true;

      final response = await _getJsonData(_bodyUrl);

      final Map<String, dynamic> comicMap = json.decode(response)['data'];

      List<Comic> allComicsResponse = [];

      comicMap['results'].forEach((value) {
        final Comic tempComic = Comic.fromMap(value);
        allComicsResponse.add(tempComic);
      });

      allComics = [...allComics, ...allComicsResponse];
      _curretpage += 20;
      print('pagina $_curretpage');
      isLodingSlider = false;
      notifyListeners();
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/comic.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_mobile_johnesteban_ap/src/widgets/toast.dart';
import 'package:crypto/crypto.dart';

class ComicsService extends ChangeNotifier {
  final String _baseUrl = 'gateway.marvel.com';
  final String _bodyUrl = '/v1/public/comics';
  final String _apikey = '91ef740484931a27809c93d3d4cc5cec';
  final String _privateKey = 'e0820a51f547642261e4d1f53bbf0423a4bcc39b';

  final String _apikey2 = 'ab172c13e5eadcee42116f385af2efc5';
  final String _privateKey2 = '3b861a8e965febcdd5e101e398539806dc7efb1a';

  String _hash = '';
  String _ts = '';
  int _curretpage = 0;

  List<Comic> comics = [];
  List<Comic> allComics = [];
  Map<int, List<Comic>> _variants = {};

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

  Map<int, List<Comic>> get variants {
    return _variants;
  }

  void hash(String _privateKey, String _apikey) {
    ts();
    var bytes = utf8.encode('$_ts$_privateKey$_apikey');
    var hash = md5.convert(bytes);
    _hash = hash.toString();
  }

  ts() {
    DateTime now = DateTime.now();
    _ts = now.toString();
  }

  Future<String> _getJsonData(String endPoint) async {
    hash(_privateKey, _apikey);

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
      isLodingSlider = false;
      notifyListeners();
    }
  }

  Future<List<Comic>> getVariantsFromComic(Comic comic) async {
    if (_variants.containsKey(comic.id)) {
      return _variants[comic.id]!;
    }

    List<Comic> allVariantsResponse = [];

    for (var i = 0; i < comic.variants!.length; i++) {
      List<String>? listUrlVariant = comic.variants![i].resourceUri?.split('/');
      String idVariant = listUrlVariant![listUrlVariant.length - 1];

      final response = await _getJsonData('$_bodyUrl/$idVariant');

      final Map<String, dynamic> comicMap = json.decode(response)['data'];

      comicMap['results'].forEach((value) {
        final Comic tempComic = Comic.fromMap(value);
        allVariantsResponse.add(tempComic);
      });
      // _variants = [..._variants, ...allVariantsResponse];
    }
    _variants[comic.id!] = allVariantsResponse;
    return allVariantsResponse;
  }
}

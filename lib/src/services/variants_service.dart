import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prueba_mobile_johnesteban_ap/src/models/comic.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_mobile_johnesteban_ap/src/models/extras.dart';
import 'package:prueba_mobile_johnesteban_ap/src/widgets/toast.dart';
import 'package:crypto/crypto.dart';

class VariantsService extends ChangeNotifier {
  final String _baseUrl = 'gateway.marvel.com';
  final String _apikey = '91ef740484931a27809c93d3d4cc5cec';
  final String _privateKey = 'e0820a51f547642261e4d1f53bbf0423a4bcc39b';
  final String _bodyUrl = '/v1/public/comics';

  //final String _apikey2 = 'ab172c13e5eadcee42116f385af2efc5';
  //final String _privateKey2 = '3b861a8e965febcdd5e101e398539806dc7efb1a';

  String _hash = '';
  String _ts = '';
  final int _curretpage = 0;
  final Map<int, List<Extras>> _variants = {};

  bool isLodingSlider = false;

  void hash(String privateKey, String apikey) {
    ts();
    var bytes = utf8.encode('$_ts$privateKey$apikey');
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

  Future<List<Extras>> getVariantsFromComic(Comic comic) async {
    if (_variants.containsKey(comic.id)) {
      return _variants[comic.id]!;
    }

    List<Extras> allVariantsResponse = [];

    for (var i = 0; i < comic.variants!.length; i++) {
      List<String>? listUrlVariant = comic.variants![i].resourceUri?.split('/');
      String idVariant = listUrlVariant![listUrlVariant.length - 1];

      final response = await _getJsonData('$_bodyUrl/$idVariant');

      final Map<String, dynamic> comicMap = json.decode(response)['data'];

      comicMap['results'].forEach((value) {
        final Comic tempComic = Comic.fromMap(value);
        Extras extras = Extras();
        extras.id = tempComic.id;
        extras.title = tempComic.title;
        extras.image =
            '${tempComic.thumbnail!.path}/portrait_fantastic.${tempComic.thumbnail!.extension}';

        allVariantsResponse.add(extras);
      });
    }
    _variants[comic.id!] = allVariantsResponse;
    return allVariantsResponse;
  }
}

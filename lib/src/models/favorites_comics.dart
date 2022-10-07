// To parse this JSON data, do
//
//     final favoritesComics = favoritesComicsFromMap(jsonString);

import 'dart:convert';

class FavoritesComics {
  FavoritesComics({
    required this.comics,
    required this.user,
  });

  List<int> comics;
  String user;

  factory FavoritesComics.fromJson(String str) =>
      FavoritesComics.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoritesComics.fromMap(Map<String, dynamic> json) => FavoritesComics(
        comics: List<int>.from(json["comics"].map((x) => x)),
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "comics": List<dynamic>.from(comics.map((x) => x)),
        "user": user,
      };
}

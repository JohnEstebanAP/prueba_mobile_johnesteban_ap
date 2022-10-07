// To parse this JSON data, do
//
//     final comic = comicFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

class Comic {
  Comic({
    this.id,
    this.digitalId,
    this.title,
    this.issueNumber,
    this.variantDescription,
    this.description,
    this.modified,
    this.isbn,
    this.upc,
    this.diamondCode,
    this.ean,
    this.issn,
    this.format,
    this.pageCount,
    this.textObjects,
    this.resourceUri,
    this.urls,
    this.series,
    this.variants,
    this.collections,
    this.collectedIssues,
    this.dates,
    this.prices,
    this.thumbnail,
    this.images,
    this.creators,
    this.characters,
    this.stories,
    this.events,
  });

  int? id;
  int? digitalId;
  String? title;
  int? issueNumber;
  String? variantDescription;
  String? description;
  String? modified;
  String? isbn;
  String? upc;
  String? diamondCode;
  String? ean;
  String? issn;
  String? format;
  int? pageCount;
  List<dynamic>? textObjects;
  String? resourceUri;
  List<Url>? urls;
  Series? series;
  List<Series>? variants;
  List<dynamic>? collections;
  List<dynamic>? collectedIssues;
  List<Date>? dates;
  List<Price>? prices;
  Thumbnail? thumbnail;
  List<dynamic>? images;
  Characters? creators;
  Characters? characters;
  Characters? stories;
  Characters? events;

  factory Comic.fromJson(String str) => Comic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comic.fromMap(Map<String, dynamic> json) => Comic(
        id: json["id"],
        digitalId: json["digitalId"],
        title: json["title"],
        issueNumber: json["issueNumber"],
        variantDescription: json["variantDescription"],
        description: json["description"],
        modified: json["modified"],
        isbn: json["isbn"],
        upc: json["upc"],
        diamondCode: json["diamondCode"],
        ean: json["ean"],
        issn: json["issn"],
        format: json["format"],
        pageCount: json["pageCount"],
        textObjects: List<dynamic>.from(json["textObjects"].map((x) => x)),
        resourceUri: json["resourceURI"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
        series: Series.fromMap(json["series"]),
        variants:
            List<Series>.from(json["variants"].map((x) => Series.fromMap(x))),
        collections: List<dynamic>.from(json["collections"].map((x) => x)),
        collectedIssues:
            List<dynamic>.from(json["collectedIssues"].map((x) => x)),
        dates: List<Date>.from(json["dates"].map((x) => Date.fromMap(x))),
        prices: List<Price>.from(json["prices"].map((x) => Price.fromMap(x))),
        thumbnail: Thumbnail.fromMap(json["thumbnail"]),
        images: List<dynamic>.from(json["images"].map((x) => x)),
        creators: Characters.fromMap(json["creators"]),
        characters: Characters.fromMap(json["characters"]),
        stories: Characters.fromMap(json["stories"]),
        events: Characters.fromMap(json["events"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "digitalId": digitalId,
        "title": title,
        "issueNumber": issueNumber,
        "variantDescription": variantDescription,
        "description": description,
        "modified": modified,
        "isbn": isbn,
        "upc": upc,
        "diamondCode": diamondCode,
        "ean": ean,
        "issn": issn,
        "format": format,
        "pageCount": pageCount,
        "textObjects": List<dynamic>.from(textObjects!.map((x) => x)),
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls!.map((x) => x.toMap())),
        "series": series!.toMap(),
        "variants": List<dynamic>.from(variants!.map((x) => x.toMap())),
        "collections": List<dynamic>.from(collections!.map((x) => x)),
        "collectedIssues": List<dynamic>.from(collectedIssues!.map((x) => x)),
        "dates": List<dynamic>.from(dates!.map((x) => x.toMap())),
        "prices": List<dynamic>.from(prices!.map((x) => x.toMap())),
        "thumbnail": thumbnail!.toMap(),
        "images": List<dynamic>.from(images!.map((x) => x)),
        "creators": creators!.toMap(),
        "characters": characters!.toMap(),
        "stories": stories!.toMap(),
        "events": events!.toMap(),
      };

  Comic copy() => Comic(
        characters: characters,
        collectedIssues: collectedIssues,
        collections: collections,
        creators: creators,
        dates: dates,
        description: description,
        diamondCode: diamondCode,
        digitalId: digitalId,
        ean: ean,
        events: events,
        format: format,
        id: id,
        images: images,
        isbn: isbn,
        issn: issn,
        issueNumber: issueNumber,
        modified: modified,
        pageCount: pageCount,
        prices: prices,
        resourceUri: resourceUri,
        series: series,
        stories: stories,
        textObjects: textObjects,
        thumbnail: thumbnail,
        title: title,
        upc: upc,
        urls: urls,
        variantDescription: variantDescription,
        variants: variants,
      );

  String get getDates {
    String dateString = '';
    var formatter = new DateFormat('yyy-MM-dd');

    dates!.reversed.forEach((date) {
      DateTime parsedDate = DateTime.parse(date.date!);
      String fecha = formatter.format(parsedDate);

      if(dateString.isEmpty){
        dateString = fecha;
      }else{
        dateString = '$dateString  -  $fecha';
      }

    });

    return dateString;
  }

  String get getModified{
    String dateString = '';
    var formatter = new DateFormat('yyy-MM-dd');

    DateTime parsedDate = DateTime.parse(modified!);
      String fecha = formatter.format(parsedDate);

      if(dateString.isEmpty){
        dateString = fecha;
      }else{
        dateString = '$dateString  -  $fecha';
      }


    return dateString;
  }
}

class Characters {
  Characters({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  int? available;
  String? collectionUri;
  List<Item>? items;
  int? returned;

  factory Characters.fromJson(String str) =>
      Characters.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Characters.fromMap(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
        "returned": returned,
      };
}

class Item {
  Item({
    this.resourceUri,
    this.name,
    this.role,
    this.type,
  });

  String? resourceUri;
  String? name;
  String? role;
  String? type;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        resourceUri: json["resourceURI"],
        name: json["name"],
        role: json["role"] == null ? null : json["role"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toMap() => {
        "resourceURI": resourceUri,
        "name": name,
        "role": role == null ? null : role,
        "type": type == null ? null : type,
      };
}

class Date {
  Date({
    this.type,
    this.date,
  });

  String? type;
  String? date;

  factory Date.fromJson(String str) => Date.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Date.fromMap(Map<String, dynamic> json) => Date(
        type: json["type"],
        date: json["date"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "date": date,
      };
}

class Price {
  Price({
    this.type,
    this.price,
  });

  String? type;
  dynamic? price;

  factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        type: json["type"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "price": price,
      };
}

class Series {
  Series({
    this.resourceUri,
    this.name,
  });

  String? resourceUri;
  String? name;

  factory Series.fromJson(String str) => Series.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Series.fromMap(Map<String, dynamic> json) => Series(
        resourceUri: json["resourceURI"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "resourceURI": resourceUri,
        "name": name,
      };
}

class Thumbnail {
  Thumbnail({
    this.path,
    this.extension,
  });

  String? path;
  String? extension;

  factory Thumbnail.fromJson(String str) => Thumbnail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Thumbnail.fromMap(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: json["extension"],
      );

  Map<String, dynamic> toMap() => {
        "path": path,
        "extension": extension,
      };
}

class Url {
  Url({
    this.type,
    this.url,
  });

  String? type;
  String? url;

  factory Url.fromJson(String str) => Url.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Url.fromMap(Map<String, dynamic> json) => Url(
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "url": url,
      };
}

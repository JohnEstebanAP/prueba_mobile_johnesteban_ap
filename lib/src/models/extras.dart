import 'dart:convert';

class Extras {
  Extras({
    this.id,
    this.title,
    this.image,
  });

  int? id;
  String? title;
  String? image;

  factory Extras.fromJson(String str) => Extras.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Extras.fromMap(Map<String, dynamic> json) =>
      Extras(id: json["id"], title: json["title"], image: json["image"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "image": image,
      };
}

import 'dart:convert';

import 'package:news_app/models/news.dart';



List<Source> sourceFromJson(String str) {
  final jsonData = json.decode(str);
  final sourcesList = jsonData['sources'];
  
  if (sourcesList is List) {
    return List<Source>.from(sourcesList.map((item) => Source.fromJson(item)));
  } else {
    return [];
  }
}

String sourceToJson(Source data) => json.encode(data.toJson());


class Source {
    String status;
    List<Result> resultats;

    Source({
        required this.status,
        required this.resultats,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        status: json["status"],
        resultats: List<Result>.from(json["resultats"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "resultats": List<dynamic>.from(resultats.map((x) => x.toJson())),
    };
}

class Result {
    String id;
    String name;
    String url;
    String description;
    List<Category> category;
    List<String> language;
    List<String> country;

    Result({
        required this.id,
        required this.name,
        required this.url,
        required this.description,
        required this.category,
        required this.language,
        required this.country,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        description: json["description"],
        category: List<Category>.from(json["category"].map((x) => categoryValues.map[x]!)),
        language: List<String>.from(json["language"].map((x) => x)),
        country: List<String>.from(json["country"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "description": description,
        "category": List<dynamic>.from(category.map((x) => categoryValues.reverse[x])),
        "language": List<dynamic>.from(language.map((x) => x)),
        "country": List<dynamic>.from(country.map((x) => x)),
    };
}

enum Category {
    BUSINESS,
    ENTERTAINMENT,
    ENVIRONMENT,
    FOOD,
    HEALTH,
    POLITICS,
    SCIENCE,
    SPORTS,
    TECHNOLOGY,
    TOP,
    TOURISM,
    WORLD
}

final categoryValues = EnumValues({
    "business": Category.BUSINESS,
    "entertainment": Category.ENTERTAINMENT,
    "environment": Category.ENVIRONMENT,
    "food": Category.FOOD,
    "health": Category.HEALTH,
    "politics": Category.POLITICS,
    "science": Category.SCIENCE,
    "sports": Category.SPORTS,
    "technology": Category.TECHNOLOGY,
    "top": Category.TOP,
    "tourism": Category.TOURISM,
    "world": Category.WORLD
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

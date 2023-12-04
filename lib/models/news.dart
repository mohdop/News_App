// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

List<Result> resultsFromJson(String str) {
  final jsonData = json.decode(str);
  final resultsList = jsonData['results'];
  
  if (resultsList is List) {
    return List<Result>.from(resultsList.map((item) => Result.fromJson(item)));
  } else {
    return [];
  }
}





String newsToJson(List<News> data) => json.encode(data.map((item) => item.toJson()).toList());

class News {
    String? status;
    int? totalResults;
    List<Result>? results;
    String? nextPage;

    News({
        this.status,
        this.totalResults,
        this.results,
        this.nextPage,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
      status: json["status"],
      totalResults: json["totalResults"],
      results: json["results"] != null
          ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
          : null, // Set results to null if it's null in the JSON
      nextPage: json["nextPage"],
    );


    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "nextPage": nextPage,
    };
}

class Result {
    String? articleId;
    String? title;
    String? link;
    List<String>? keywords;
    List<String>? creator;
    dynamic? videoUrl;
    String? description;
    String? content;
    DateTime? pubDate;
    String? imageUrl;
    String? sourceId;
    int? sourcePriority;
    List<String>? country;
    List<Category>? category;
    String? language;

    Result({
        this.articleId,
        this.title,
        this.link,
        this.keywords,
        this.creator,
        this.videoUrl,
        this.description,
        this.content,
        this.pubDate,
        this.imageUrl,
        this.sourceId,
        this.sourcePriority,
        this.country,
        this.category,
        this.language,
    });

    factory Result.fromJson(Map<String, dynamic> json) {
  return Result(
    articleId: json["article_id"],
    title: json["title"],
    link: json["link"],
    keywords: List<String>.from(json["keywords"] ?? []),
    creator: List<String>.from(json["creator"] ?? []),
    videoUrl: json["video_url"],
    description: json["description"],
    content: json["content"],
    pubDate: json["pubDate"] != null ? DateTime.parse(json["pubDate"]) : null,
    imageUrl: json["image_url"],
    sourceId: json["source_id"],
    sourcePriority: json["source_priority"],
    country: List<String>.from(json["country"] ?? []),
   category: json["category"] != null
        ? List<Category>.from(json["category"].map((x) {
            if (categoryValues.map.containsKey(x)) {
              return categoryValues.map[x]!;
            } else {
              // Handle unknown category
              return Category.ENTERTAINMENT;
            }
          }))
        : [],
    language: json["language"],
  );
}


    Map<String, dynamic> toJson() => {
        "article_id": articleId,
        "title": title,
        "link": link,
        "keywords": List<dynamic>.from(keywords!.map((x) => x)),
        "creator": List<dynamic>.from(creator!.map((x) => x)),
        "video_url": videoUrl,
        "description": description,
        "content": content,
        "image_url": imageUrl,
        "source_id": sourceId,
        "source_priority": sourcePriority,
        "country": List<dynamic>.from(country!.map((x) => x)),
        "category": List<dynamic>.from(category!.map((x) => categoryValues.reverse[x])),
        "language": language,
    };
}

enum Category {
    ENTERTAINMENT,
    SPORTS,
    TOP
}

final categoryValues = EnumValues({
    "entertainment": Category.ENTERTAINMENT,
    "sports": Category.SPORTS,
    "top": Category.TOP
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

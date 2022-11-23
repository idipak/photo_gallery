
import 'dart:convert';

PhotoResponse photoResponseFromJson(String str) => PhotoResponse.fromJson(json.decode(str));


class PhotoResponse {
  PhotoResponse({
    required this.total,
    required this.totalPages,
    required this.results,
  });

  final int total;
  final int totalPages;
  final List<Result> results;

  factory PhotoResponse.fromJson(Map<String, dynamic> json) => PhotoResponse(
    total: json["total"],
    totalPages: json["total_pages"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

}

class Result {
  Result({
    required this.urls,
    required this.tags,
  });
  final Urls urls;
  final List<Tag> tags;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    urls: Urls.fromJson(json["urls"]),
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
  );
}

class Tag {
  Tag({
    required this.title,
  });

  final String title;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    title: json["title"],
  );

}



class Urls {
  Urls({
    required this.regular,
  });

  final String regular;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(

    regular: json["regular"],
  );

}

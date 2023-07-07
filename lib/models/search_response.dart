// To parse this JSON data, do
//
//     final searchReponse = searchReponseFromJson(jsonString);

import 'dart:convert';

import 'package:peliculas/models/models.dart';

SearchReponse searchReponseFromJson(String str) => SearchReponse.fromJson(json.decode(str));

String searchReponseToJson(SearchReponse data) => json.encode(data.toJson());

class SearchReponse {
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    SearchReponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory SearchReponse.fromJson(String str) => SearchReponse.fromMap(json.decode(str));

    factory SearchReponse.fromMap(Map<String, dynamic> json) => SearchReponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}
// To parse this JSON data, do
//
//     final creditsReponse = creditsReponseFromJson(jsonString);

import 'dart:convert';

CreditsReponse creditsReponseFromJson(String str) => CreditsReponse.fromJson(json.decode(str));

String creditsReponseToJson(CreditsReponse data) => json.encode(data.toJson());

class CreditsReponse {
    int id;
    List<Cast> cast;
    List<Cast> crew;

    CreditsReponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory CreditsReponse.fromJson(String str) => CreditsReponse.fromMap(json.decode(str));

    factory CreditsReponse.fromMap(Map<String, dynamic> json) => CreditsReponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    };
}



class Cast {
    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String? department;
    String? job;

    get fullProfilePath{

      if(profilePath != null){
        return 'https://image.tmdb.org/t/p/w500${ profilePath! }';
      }
      return 'https://i.stack.imgur.com/GNhxO.png';

      
    }

    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    

    factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": department,
        "job": job,
    };
}

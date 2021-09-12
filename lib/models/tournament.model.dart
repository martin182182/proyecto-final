import 'dart:convert';

TournamentM tournamentFromJson(String str) => TournamentM.fromJson(json.decode(str));

String tournamentToJson(TournamentM data) => json.encode(data.toJson());

class TournamentM {
    TournamentM({
        required this.name,
        required this.city,
        required this.point1,
        required this.point2,
        required this.prize,
        required this.description,
    });

    String name;
    String city;
    double point1;
    double point2;
    String prize;
    String description;

    factory TournamentM.fromJson(Map<String, dynamic> json) => TournamentM(
        name: json["name"],
        city: json["city"],
        point1: json["point1"],
        point2: json["point2"],
        prize: json["prize"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "city": city,
        "point1": point1,
        "point2": point2,
        "prize": prize,
        "description": description,
    };
}

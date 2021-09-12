import 'dart:convert';

NoteM noteMFromJson(String str) => NoteM.fromJson(json.decode(str));

String noteMToJson(NoteM data) => json.encode(data.toJson());

class NoteM {
    NoteM({
        required this.jugada,
        required this.descripcion,
        required this.fen,
        required this.gameID,
    });
    String jugada;
    String descripcion;
    String fen;
    int gameID;

    factory NoteM.fromJson(Map<String, dynamic> json) => NoteM(
        jugada: json["jugada"],
        descripcion: json["descripcion"],
        fen: json["fen"],
        gameID: json["gameID"],
    );

    Map<String, dynamic> toJson() => {
        "jugada": jugada,
        "descripcion": descripcion,
        "fen": fen,
        "gameID": gameID,
    };
}

import 'dart:convert';

import 'package:chesslib_final/models/tournament.model.dart';
import 'package:http/http.dart' as http;

class TournamentS{
  Future<List<TournamentM>> getTournaments() async {
    List<TournamentM> tournaments = [];
    final url = Uri.parse("http://192.168.100.5:3000/api/list");
    final res = await http.get(url);
    var list = [];
    if(res.statusCode==200){
      final Map<String,dynamic> jsonData = json.decode(res.body)['tournaments'];
      jsonData.entries.forEach((e) => list.add([e.key, e.value]));
      for(var i=0;i<list.length;i++){
        var tournament = new TournamentM(name: list[i][1]["name"], city: list[i][1]["city"], point1: list[i][1]["point1"], point2: list[i][1]["point2"], prize: list[i][1]["prize"], description: list[i][1]["description"]);
        tournaments.add(tournament);
      }
    }
    return tournaments; 
  } 
}
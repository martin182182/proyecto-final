//@dart = 2.9
import 'package:chesslib_final/models/tournament.model.dart';
import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class Localization extends StatefulWidget {
  final tournament;
  Localization(this.tournament);
  @override
  _LocalizationState createState() => _LocalizationState(tournament);
}

class _LocalizationState extends State<Localization> {
  TournamentM tournament;
  _LocalizationState(this.tournament);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: new Center(
                child:
                  new Text(tournament.name, style: new TextStyle(fontSize: 30.0,color: Colors.white))),
            backgroundColor: Colors.black
          ),
        /*body: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: 
        CameraPosition(zoom: 20,target: LatLng(tournament.point1, tournament.point2))), */
         
    );
  }
}
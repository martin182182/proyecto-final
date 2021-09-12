//@dart = 2.9
import 'package:chesslib_final/models/tournament.model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    print(tournament.point1);
    print(tournament.point2);
    return Scaffold(
        appBar: new AppBar(
            title: new Center(
                child:
                  new Text(tournament.name, style: new TextStyle(fontSize: 30.0,color: Colors.white))),
            backgroundColor: Colors.black
          ),
        body: GoogleMap(
        myLocationButtonEnabled: true,  
        markers: _createMarkers(),
        myLocationEnabled: true,
        initialCameraPosition: 
        CameraPosition(zoom: 17,target: LatLng(tournament.point1,tournament.point2)
        )),
         
    );
  }
  Set<Marker> _createMarkers() {
  var tmp = Set<Marker>();

  tmp.add(
    Marker(
      markerId: MarkerId("fromPoint"),
      position: LatLng(tournament.point1,tournament.point2),
      infoWindow: InfoWindow(title: "Pizzeria"),
    ),
  );
  return tmp;
  } 
}



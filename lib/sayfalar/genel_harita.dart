import 'dart:async';

import 'package:case_study/db/db_yardim.dart';
import 'package:case_study/sayfalar/gider_detay.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GenelHarita extends StatefulWidget {
  const GenelHarita({Key? key}) : super(key: key);

  @override
  _GenelHaritaState createState() => _GenelHaritaState();
}

double _originLatitude = 41.075433;
double _originLongitude = 28.9939738;

class _GenelHaritaState extends State<GenelHarita> {
  //HARİTA
  late GoogleMapController _controller;

  DbYardim dbYardim = DbYardim();
  int uzunluk = 0;
  List bilgiler = [];

  @override
  void initState() {
    dbYardim.queryGider().then((value) {
      uzunluk = value.length;
      bilgiler = value;
      loadLocations();
    });

    super.initState();
  }

  static final CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 5,
  );

  List<Marker> _markers = [];

  void loadLocations() async {
    //we store the response in a list
    for (int i = 0; i < bilgiler.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(bilgiler[i].giderId.toString()),
        position: LatLng(bilgiler[i].giderLa, bilgiler[i].giderLo),
        infoWindow: InfoWindow(
          title: bilgiler[i].giderAciklama,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GiderDetay(gelenId: bilgiler[i].giderId),
              ),
            );
          },
        ),
      ));
    }
    setState(() {
      print(_markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Genel Harita"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GoogleMap(
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _initalCameraPosition,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
        ),
      ),
    );
  }
}

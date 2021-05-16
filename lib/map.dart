import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

Set<Marker> initial_markers = {
  Marker(markerId: MarkerId('id-2'), position: LatLng(37.7785, -122.4067)),
  Marker(markerId: MarkerId('id-1'), position: LatLng(37.7885, -122.4056)),
  Marker(markerId: MarkerId('id-3'), position: LatLng(37.7985, -122.4078)),
  Marker(markerId: MarkerId('id-4'), position: LatLng(37.7685, -122.4089)),
  Marker(markerId: MarkerId('id-5'), position: LatLng(37.7585, -122.4090)),
  Marker(markerId: MarkerId('id-6'), position: LatLng(37.7485, -122.4101)),
};

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> mapController = Completer(); 

  /* 
  COMMENT: original code @ line 12
  was a Completer.
  */

  Set<Marker> _markers = {};

  final LatLng _center = const LatLng(37.7785, -122.4056);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers = initial_markers;
    });
    controller.setMapStyle(Utils.mapStyle);
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14,
            ),
          ),
          _buildContainer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.map,
                    // size: 36,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContainer() {
    /*
    Builds the cafeCardList
    */
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 256.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg",
                    37.7785,
                    -122.4067,
                    "Eco Leaf"),
              ),
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg",
                    37.7785,
                    -122.4067,
                    "Eco Leaf"),
              ),
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg",
                    37.7785,
                    -122.4067,
                    "Eco Leaf"),
              ),
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _boxes(
                    "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg",
                    37.7785,
                    -122.4067,
                    "Eco Leaf"),
              )
            ],
          )),
    );
  }

  Widget _boxes(String _image, double lat, double long, String cafeName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: ClipRRect(
                    borderRadius: new BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      width: 343,
                      height: 105,
                      image: NetworkImage(_image),
                    ),
                  ),
                ),
                Container(
                  width: 343,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cafeInfoContainer(cafeName),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}


Widget cafeInfoContainer(String cafeName) {
  return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "Open | 0.06MI",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                Container(
                  child: Text(
                    "\u00B7 \u0024\u0024 \u00B7",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              cafeName,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Text(
              "Close at 6 pm",
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          SizedBox(height: 32.0),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "GO NOW",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                // onPressed(){}
                // textAlign: TextAlign.center,
              ),
            ],
          )),
          SizedBox(height: 16.0),
        ],
      ));
}

class Utils {
  static String mapStyle = '''
  [
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]
  ''';
}

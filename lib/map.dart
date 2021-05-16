import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }
    double zoomVal=5.0;
  @override
  Widget build(BuildContext context) {
    // create markers from initial_cafes
    // for each cafe in initial_cafes
      // create a marker for that cafe
    for (final my_cafe in initial_cafes) {
      _markers.add(Marker(markerId: my_cafe.markerId, 
                          position: my_cafe.position, 
                          infoWindow: InfoWindow(title: my_cafe.name),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue
                            )
                          )
                  );
    }
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     icon: Icon(FontAwesomeIcons.arrowLeft),
        //     onPressed: () {
        //       //
        //     }),
        // title: Text("New York"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _buildContainer(),
        ],
      ),
    );
  }
  
  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg",
                  40.738380, -73.988426,"Gramercy Tavern"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg",
                  40.761421, -73.981667,"Le Bernardin"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg",
                  40.732128, -73.999619,"Blue Hill"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String restaurantName) {
    return  GestureDetector(
        onTap: () {
          _gotoLocation(lat,long);
        },
        child:Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 180,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(_image),
                            ),
                          ),),
                          Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myDetailsContainer1(restaurantName),
                          ),
                        ),

                      ],)
                ),
              ),
            ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height:5.0),
        Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                "4.1",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStarHalf,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
               Container(
                  child: Text(
                "(946)",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
          SizedBox(height:5.0),
        Container(
                  child: Text(
                "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              SizedBox(height:5.0),
        Container(
            child: Text(
          "Closed \u00B7 Opens 17:00 Thu",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(37.7685, -122.4089), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(Utils.mapStyle);
          _controller.complete(controller);
        },
        markers:_markers
        // markers: {
        //   newyork1Marker,newyork2Marker,newyork3Marker,gramercyMarker,bernardinMarker,blueMarker
        // },
      ),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}

class EcoCafe {
  MarkerId markerId;
  String name;
  String pictureUrl;
  LatLng position;
  bool acceptsReusableCups;

  EcoCafe({
    this.markerId, 
    this.name, 
    this.pictureUrl, 
    this.position,
    this.acceptsReusableCups
  });
}

List<EcoCafe> initial_cafes = [
  EcoCafe(markerId: MarkerId('id-1'), name: 'EcoCafe', position: LatLng(37.7785, -122.4067), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: true),
  EcoCafe(markerId: MarkerId('id-2'), name: 'CoolCafe', position: LatLng(37.7885, -122.4056), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: true),
  EcoCafe(markerId: MarkerId('id-3'), name: 'WaCafe', position: LatLng(37.7985, -122.4078), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: false),
  EcoCafe(markerId: MarkerId('id-4'), name: 'IsCafe', position: LatLng(37.7685, -122.4089), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: false),
  EcoCafe(markerId: MarkerId('id-5'), name: 'ReallyCafe', position: LatLng(37.7585, -122.4090), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: true),
  EcoCafe(markerId: MarkerId('id-6'), name: 'GoodCafe', position: LatLng(37.7485, -122.4101), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: true),
];


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
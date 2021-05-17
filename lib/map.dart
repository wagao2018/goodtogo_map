import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:good_to_go_app/CafeList.dart';

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
          Consumer<CafeList>(builder: (context, cafeListData, child){
            return _buildGoogleMap(context, cafeListData.items, cafeListData.isFilteringCafes);
          }),
          Consumer<CafeList>(builder: (context, cafeListData, child){
            return _buildContainer(cafeListData.items, cafeListData.isFilteringCafes);
          }),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
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
                child: FloatingActionButton( // Filter button
                  onPressed: () {
                    Provider.of<CafeList>(context, listen:false).switchFilter();
                  },
                  child: Icon(
                    Icons.map,
                    // size: 36,
                  ),
                ),
              ),
            ],
          );
  }
  Widget _buildContainer(cafes, useFilter) {
    List<Widget> cafe_card_list = [];
    cafe_card_list.add(SizedBox(width:8.0));
    for(final my_cafe in cafes) {
      // format this cafe into a widget
      Padding my_cafe_widget = Padding(
                               padding: const EdgeInsets.all(8.0), 
                               child: _boxes(my_cafe.pictureUrl,
                                             my_cafe.position.latitude, 
                                             my_cafe.position.longitude, 
                                             my_cafe.name)
                              );
      if(useFilter) {
        if(my_cafe.acceptsReusableCups) {
          cafe_card_list.add(my_cafe_widget);
        }
      } else {
        cafe_card_list.add(my_cafe_widget);
      }

      // add the cafe's widget to card_list                              
      cafe_card_list.add(SizedBox(width: 8.0));
    }
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 256.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: cafe_card_list,
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String cafeName) {
  return GestureDetector(
    onTap: () {
     _gotoLocation(lat,long);
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

  Widget _buildGoogleMap(context, cafes, useFilter) {
    _controller = Completer();
    _markers = {}; // clear markers
    for (final my_cafe in cafes) {
      if(useFilter) {
        if(my_cafe.acceptsReusableCups) {
            _markers.add(Marker(markerId: my_cafe.markerId, 
                                position: my_cafe.position, 
                                infoWindow: InfoWindow(title: my_cafe.name),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue
                                  )
                                )
                        );
        }
      } else {
            _markers.add(Marker(markerId: my_cafe.markerId, 
                                position: my_cafe.position, 
                                infoWindow: InfoWindow(title: my_cafe.name),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue
                                  )
                                )
                        );
      }
    }    
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
      ),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
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
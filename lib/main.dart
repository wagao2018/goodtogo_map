import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoodToGo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  // final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Set<Marker> initial_markers = {
      Marker(markerId: MarkerId('id-2'), position: LatLng(37.7785, -122.4067)),
      Marker(markerId: MarkerId('id-1'), position: LatLng(37.7885, -122.4056)),
      Marker(markerId: MarkerId('id-3'), position: LatLng(37.7985, -122.4078)),
      Marker(markerId: MarkerId('id-4'), position: LatLng(37.7685, -122.4089)),
      Marker(markerId: MarkerId('id-5'), position: LatLng(37.7585, -122.4090)),
      Marker(markerId: MarkerId('id-6'), position: LatLng(37.7485, -122.4101)),
};

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            // _buildContainer(),
          ],
        ),
      ),
    );
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

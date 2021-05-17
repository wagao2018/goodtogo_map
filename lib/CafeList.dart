import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class CafeList extends ChangeNotifier {
  final List<EcoCafe> items = [
                                EcoCafe(markerId: MarkerId('id-1'), name: 'EcoCafe', position: LatLng(37.7785, -122.4067), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: true),
                                EcoCafe(markerId: MarkerId('id-2'), name: 'CoolCafe', position: LatLng(37.7885, -122.4056), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: true),
                                EcoCafe(markerId: MarkerId('id-3'), name: 'WaCafe', position: LatLng(37.7985, -122.4078), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: false),
                                EcoCafe(markerId: MarkerId('id-4'), name: 'IsCafe', position: LatLng(37.7685, -122.4089), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: false),
                                EcoCafe(markerId: MarkerId('id-5'), name: 'ReallyCafe', position: LatLng(37.7585, -122.4090), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: true),
                                EcoCafe(markerId: MarkerId('id-6'), name: 'GoodCafe', position: LatLng(37.7485, -122.4101), pictureUrl: "https://cafeastoria-stpaul.com/wp-content/uploads/2020/08/cafeastoria-interior2.jpg", acceptsReusableCups: true),
                              ];
  bool isFilteringCafes = false;

  void switchFilter (){
    isFilteringCafes = !isFilteringCafes;
    notifyListeners();
  }
}


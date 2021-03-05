import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_x_flutter_app/core/managers/launchpad_manager.dart';
import 'package:space_x_flutter_app/core/models/launchpad.dart';

class MyMapPage extends StatefulWidget {
  MyMapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  Completer<GoogleMapController> _controller = Completer();


  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {

    super.initState();
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/pinRocket.png').then((onValue) {
      pinLocationIcon = onValue;
    });
    //setCustomMapPin();
  }



  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future : LaunchPadManager().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var launchPads = snapshot.data as List<LaunchPad>;
            return Column(children: [
              Flexible(child:
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  if (launchPads.isNotEmpty) {
                    setState(() {
                      _markers.clear();
                      launchPads.forEach((element) {
                        if (!element.longitude.isNaN && !element.latitude.isNaN){
                          _markers.add(
                              Marker(
                                  markerId: MarkerId("${element.id}_pin"),
                                  position: LatLng(element.latitude, element.longitude),
                                  icon:pinLocationIcon
                              )
                          );
                        }
                      });
                    });
                  }
                },
                markers: _markers,
              ),
                flex: 4),
              Flexible(child:
                ListView.builder(
                  itemCount : launchPads.length - 1,
                  itemBuilder: (context,position){
                    return ListTile(
                      title: Text(launchPads[position].name,style: new TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("lat : ${launchPads[position].latitude}/ long : ${launchPads[position].longitude}"),
                      onTap: () {
                        _goToThePosition(launchPads[position].latitude,
                            launchPads[position].longitude);
                      },
                    );
                  }),
                flex: 2,
              )

            ],);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _goToThePosition(double latitude, double longitude) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 14.4746,
            )
        )
    );
  }
}

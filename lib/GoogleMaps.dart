import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        markers: <Marker>{
          Marker(
            infoWindow: InfoWindow(
              title: "نمایندگی دیجی کالا شعبه بابل"
            ),
            position: LatLng(36.563343220861384, 52.68631404524906),
              markerId: MarkerId("1")
          ),
          Marker(
              infoWindow: InfoWindow(
                  title: "نمایندگی دیجی کالا شعبه فم"
              ),
              position: LatLng(34.650102554966004, 50.86593728274735),
              markerId: MarkerId("1")
          ),
          Marker(
              infoWindow: InfoWindow(
                  title: "نمایندگی دیجی کالا شعبه اصفهان"
              ),
              position: LatLng(32.64157494327089, 51.610205525538966),
              markerId: MarkerId("1")
          )
        },
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(35.68613717313875, 51.3930854502461),
          zoom: 5
        ),
        onMapCreated:  (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}

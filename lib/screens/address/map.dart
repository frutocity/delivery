import 'package:app/app/common_widgets/app_button.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/styles/colors.dart';
import 'package:app/screens/address/add_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'select_address.dart';

class MapScreen extends StatefulWidget {
  double lat;
  double long;
  String description;
  MapScreen(this.lat, this.long, this.description);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = Set();
  @override
  void initState() {
    super.initState();
    setMarker();
  }

  var subLocality;
  var fullAddress;

  setMarker() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(widget.lat, widget.long);
    print("nvsjrnvkl$placemark");
    setState(() {
      subLocality = placemark[0].subLocality;
      fullAddress = placemark[0];
    });
    _markers.add(Marker(
      icon: BitmapDescriptor.defaultMarker,
      markerId: const MarkerId("Marker"),
      position: LatLng(widget.lat, widget.long),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTransparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_sharp,
              color: colorBlack,
            )),
        title: AppText(
          text: "Set Delivery Location",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  buildingsEnabled: true,
                  markers: _markers,
                  onCameraMoveStarted: (() {
                    _markers.add(Marker(
                      icon: BitmapDescriptor.defaultMarker,
                      markerId: const MarkerId("Marker"),
                      position: LatLng(widget.lat, widget.long),
                    ));
                  }),
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                      zoom: 18, target: LatLng(widget.lat, widget.long))),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppText(
                      text: "${subLocality}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.description}"),
                  ),
                  AppButton(
                    label: "confirm Location",
                    onPressed: () {
                      Get.to(() => AddAddress(widget.description));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  var locationLoading = ValueNotifier(true);
  Position? position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentPosition();
  }

  getCurrentPosition() async {
    try {
      position = await determinePosition();
      locationLoading.value = false;
    } catch (e) {
      showSnackBar(context, e.toString());
      locationLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Location"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: locationLoading,
          builder: (context, value, child) {
            if (value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else {
              return GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    zoom: 14,
                    target: LatLng(position!.latitude, position!.longitude)),
              );
            }
          }),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      return await Geolocator.getCurrentPosition();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

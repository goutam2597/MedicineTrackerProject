import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class NearbyMedicineStoreScreen extends StatefulWidget {
  const NearbyMedicineStoreScreen({super.key});

  @override
  State<NearbyMedicineStoreScreen> createState() => _NearbyMedicineStoreScreenState();
}

class _NearbyMedicineStoreScreenState extends State<NearbyMedicineStoreScreen> {
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  late LatLng _userLocation = const LatLng(0, 0);
  late Timer _locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _getCurrentLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _locationUpdateTimer.cancel();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
      _markers.clear();

      _markers.add(Marker(
        markerId: const MarkerId('userLocation'),
        position: _userLocation,
        infoWindow: InfoWindow(
          title: 'Your Location',
          snippet: 'Lat: ${position.latitude}, Long: ${position.longitude}',
        ),
      ));

      _animateToUserLocation();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _animateToUserLocation() {
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(_userLocation, 17.0));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Medicine Shop'),
      ),
      body: GoogleMap(
        markers: _markers,
        onMapCreated: (controller){
          _mapController=controller;
        },
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          zoom: 18,
          target: _userLocation,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateToUserLocation, // Call the zoom function
        child: const Icon(Icons.location_searching),
      ),

    );
  }
}

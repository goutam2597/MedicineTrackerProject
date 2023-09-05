import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/pages/drawer_screens/price_tracker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'buy_medicine_online_screen.dart';
import 'medicine_donation_networks.dart';
import 'medicine_tracker_screen.dart';

class NearbyMedicineStoreScreen extends StatefulWidget {
  const NearbyMedicineStoreScreen({super.key});

  @override
  State<NearbyMedicineStoreScreen> createState() =>
      _NearbyMedicineStoreScreenState();
}

class _NearbyMedicineStoreScreenState extends State<NearbyMedicineStoreScreen> {
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  late LatLng _userLocation = const LatLng(0, 0);
  late Timer _locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _getCurrentLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _locationUpdateTimer.cancel();
  }

  void _requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (!status.isGranted) {
      Get.snackbar('Ops!','Location access denied',colorText: kSnackBarColor, );
    }else{
      Get.snackbar('Congratulations!','Location access granted',colorText: kSnackBarColor,);
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _markers.add(Marker(
        markerId: const MarkerId('userLocation'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
          title: 'Current Location',
          snippet: 'Lat: ${position.latitude}, Long: ${position.longitude}',
        ),
      ));
      _markers.add(Marker(
        markerId: const MarkerId('marker1'),
        position: const LatLng(23.823198964021348, 90.353209938535),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: const InfoWindow(
          title: 'Khan Homeo Hall',
        ),
      ));
      _markers.add(Marker(
        markerId: const MarkerId('marker2'),
        position: const LatLng(23.823382989482973, 90.35290014341612),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: const InfoWindow(
          title: 'Alifa Pharmacy',
        ),
      ));
      _markers.add(Marker(
        markerId: const MarkerId('marker3'),
        position: const LatLng(23.823476842370145, 90.35356667233485),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: const InfoWindow(
          title: 'Saida Pharmacy',
        ),
      ));
      _markers.add(Marker(
        markerId: const MarkerId('marker4'),
        position: const LatLng(23.82343942390689, 90.35409573805313),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: const InfoWindow(
          title: 'M/S. Reeha Medicine Point',
        ),
      ));

      _markers.add(Marker(
        markerId: const MarkerId('marker5'),
        position: const LatLng(23.82338544316034, 90.35462815653977),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: const InfoWindow(
          title: 'Hridoy Drug House',
        ),
      ));

      _markers.add(Marker(
        markerId: const MarkerId('marker6'),
        position: const LatLng(23.824439390561597, 90.3541343144977),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: const InfoWindow(
          title: 'Alpha Dental Care',
        ),
      ));

      _markers.add(Marker(
        markerId: const MarkerId('marker7'),
        position: const LatLng(23.824185571720253, 90.35220321128566),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: const InfoWindow(
          title: 'M General Hospital and Diagnostic Center',
        ),
      ));

      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });

      _animateToUserLocation();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _animateToUserLocation() {
    _mapController
        .animateCamera(CameraUpdate.newLatLngZoom(_userLocation, 17.0));
  }

  Future<void> _searchLocation(String searchText) async {
    try {
      List<Location> locations = await locationFromAddress(searchText);

      if (locations.isNotEmpty) {
        final Location location = locations.first;
        final LatLng target = LatLng(location.latitude, location.longitude);

        _mapController.animateCamera(CameraUpdate.newLatLng(target));
      } else {
        Get.snackbar('Ops!', 'Location not found',colorText: kSnackBarColor,);
      }
    } catch (e) {
      print("Error searching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearby Pharmacy',
          style: GoogleFonts.rubik(
              textStyle: const TextStyle(color: Colors.white, fontSize: 23)),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: LocationSearch(_searchLocation),
                  );
                },
                icon: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 23,
                )),
          ),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 150,
                width: double.infinity,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Medicine Tracker',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                leading: const Icon(
                  Icons.add_chart,
                  color: kPrimaryColor,
                ),
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to(const MedicineTrackerScreen());
                },
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Medicine Search',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                leading: const Icon(Icons.search, color: kPrimaryColor),
                horizontalTitleGap: 0,
                onTap: () {},
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Price Tracker',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                leading: const Icon(Icons.currency_exchange_outlined,
                    color: kPrimaryColor),
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to(const PriceTrackerScreen());
                },
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Medicine Side Effects',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                leading: const Icon(
                  Icons.error,
                  color: kPrimaryColor,
                ),
                horizontalTitleGap: 0,
                onTap: () {},
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                  title: const Text(
                    'Nearby Medicine Shop',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  leading: const Icon(
                    Icons.local_convenience_store,
                    color: kPrimaryColor,
                  ),
                  horizontalTitleGap: 0,
                  onTap: () {
                    Get.to(const NearbyMedicineStoreScreen());
                  }),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Buy Medicine Online',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                leading: const Icon(
                  Icons.local_grocery_store,
                  color: kPrimaryColor,
                ),
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to(const BuyMedicineOnline());
                },
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Medication Donation Network',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                leading: const FaIcon(
                  FontAwesomeIcons.handHoldingMedical,
                  color: kPrimaryColor,
                ),
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to(const MedicineDonationNetworks());
                },
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              const Spacer(),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'About Us',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
                leading: const Icon(
                  Icons.info,
                  color: kPrimaryColor,
                ),
                horizontalTitleGap: 0,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: GoogleMap(
        markers: _markers,
        onMapCreated: (controller) {
          _mapController = controller;
        },
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          zoom: 18,
          target: _userLocation,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateToUserLocation,
        backgroundColor: kPrimaryColor, // Call the zoom function
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
class LocationSearch extends SearchDelegate<String> {
  final Function(String) onSearch;

  LocationSearch(this.onSearch);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: kPrimaryColor, // Set the background color here
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text("Search for a location..."),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Search for a location..."),
    );
  }
}

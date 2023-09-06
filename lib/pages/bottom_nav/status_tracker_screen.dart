import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/pages/drawer_screens/about_us_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/ambulance_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/buy_medicine_online_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/first_aids_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/medicine_donation_networks.dart';
import 'package:medicine_reminder/pages/drawer_screens/medicine_side_effects_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class StatusTrackerScreen extends StatefulWidget {
  const StatusTrackerScreen({super.key});

  @override
  StatusTrackerScreenState createState() => StatusTrackerScreenState();
}

class StatusTrackerScreenState extends State<StatusTrackerScreen> {


  Uri dialNumber = Uri(scheme: 'tel',path: '12345678901');

  callNumber()async{
    await launchUrl(dialNumber);
  }

  int totalDose = 0;
  int dailyDose = 0;
  List<bool> doseTaken = [];

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  void loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        totalDose = prefs.getInt('totalDose') ?? 0;
        dailyDose = prefs.getInt('dailyDose') ?? 0;
        doseTaken = List.generate(
            totalDose, (index) => prefs.getBool('day_$index') ?? false);
      });
    } catch (e) {
      log("Error loading data from SharedPreferences: $e");
    }
  }

  void saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      for (int i = 0; i < totalDose; i++) {
        prefs.setBool('day_$i', doseTaken[i]);
      }
    } catch (e) {
      log("Error saving data to SharedPreferences: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      totalDose = args['totalDose'] ?? 0;
      dailyDose = args['dailyDose'] ?? 0;
    }

    log('totalDose: $totalDose');
    log('doseTaken length: ${doseTaken.length}');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Status Tracker',
          style: GoogleFonts.rubik(
              textStyle: const TextStyle(color: Colors.white, fontSize: 23)),
        ),
        centerTitle: true,
        elevation: 2,
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
                  'First Aid Medicines',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                leading: const FaIcon(
                  FontAwesomeIcons.briefcaseMedical,
                  color: kPrimaryColor,
                  size: 25,
                ),
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to(const FirstAidsScreen());
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
                onTap: () {
                  Get.to(const MedicineSideEffectsScreen());
                },
              ),
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
                  Get.to( BuyMedicineOnline());
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
                  Get.to( MedicineDonationNetworks());
                },
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Call For Medicine',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                leading: const FaIcon(
                  FontAwesomeIcons.phone,
                  color: kPrimaryColor,
                ),
                horizontalTitleGap: 0,
                onTap: callNumber,
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Call Ambulance',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                leading: const FaIcon(
                  FontAwesomeIcons.truckMedical,
                  color: kPrimaryColor,
                ),
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to( const AmbulanceScreen());
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
                    color: Colors.black54,
                  ),
                ),
                leading: const Icon(
                  Icons.info,
                  color: kPrimaryColor,
                ),
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to(const AboutUsScreen());
                },
              ),
            ],
          ),
        ),
      ),
      body: totalDose > 0
          ? ListView.builder(
              itemCount: totalDose,
              itemBuilder: (context, index) {
                log('Accessing index $index');
                return Card(
                  child: ListTile(
                    title: Text('Dose Number :  ${index + 1}'),
                    trailing: Checkbox(
                      activeColor: kPrimaryColor,
                      value: doseTaken[index],
                      onChanged: (value) {
                        setState(() {
                          doseTaken[index] = value!;
                          saveData();
                        });
                      },
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('No doses to display.'),
            ),
    );
  }
}

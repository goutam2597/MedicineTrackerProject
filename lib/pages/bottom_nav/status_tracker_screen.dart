import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/pages/bottom_nav/nearby_medicine_store_screen.dart';
import 'package:medicine_reminder/pages/bottom_nav/price_tracker.dart';
import 'package:medicine_reminder/pages/drawer_screens/buy_medicine_online_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/medicine_donation_networks.dart';
import 'package:medicine_reminder/pages/status_tracker/floating_action_button_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusTrackerScreen extends StatefulWidget {
  @override
  _StatusTrackerScreenState createState() => _StatusTrackerScreenState();
}

class _StatusTrackerScreenState extends State<StatusTrackerScreen> {
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
      print("Error loading data from SharedPreferences: $e");
    }
  }

  void saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      for (int i = 0; i < totalDose; i++) {
        prefs.setBool('day_$i', doseTaken[i]);
      }
    } catch (e) {
      print("Error saving data to SharedPreferences: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      totalDose = args['totalDose'] ?? 0;
      dailyDose = args['dailyDose'] ?? 0;
    }

    print('totalDose: $totalDose');
    print('doseTaken length: ${doseTaken.length}');

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
      body: ListView.builder(
        itemCount: totalDose,
        itemBuilder: (context, index) {
          print('Accessing index $index');
          return Card(
            child: ListTile(
              title: Text('Dose ${index + 1}'),
              trailing: Checkbox(
                value: doseTaken[index],
                onChanged: (value) {
                  setState(() {
                    doseTaken[index] = value!;
                    saveData(); // Save the updated data when the checkbox is changed
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: (){
          Get.to(FabFormField());
        },
        child: const Icon(Icons.add,size: 40,),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/pages/bottom_nav/nearby_medicine_store_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/buy_medicine_online_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/medicine_donation_networks.dart';
import 'package:medicine_reminder/pages/bottom_nav/status_tracker_screen.dart';

class PriceTrackerScreen extends StatefulWidget {
  const PriceTrackerScreen({super.key});

  @override
  State<PriceTrackerScreen> createState() => _PriceTrackerScreenState();
}

class _PriceTrackerScreenState extends State<PriceTrackerScreen> {
  TextEditingController searchController = TextEditingController();

  CollectionReference referenceMedicinePrice =
      FirebaseFirestore.instance.collection('medicine_price');
  late Stream<QuerySnapshot> streamMedicinePrice;

  List<QueryDocumentSnapshot> listQueryDocumentSnapshot = [];
  List<QueryDocumentSnapshot> filteredMedicineList = [];

  @override
  void initState() {
    super.initState();
    streamMedicinePrice = referenceMedicinePrice.snapshots();
  }

  void filterMedicineList(String query) {
    print('Search Query: $query'); // Debug print
    setState(() {
      filteredMedicineList = listQueryDocumentSnapshot
          .where((document) =>
          (document['name'] as String)
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      print('Filtered List Length: ${filteredMedicineList.length}'); // Debug print
    });
  }
  void showSearchBar() {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medicine Price',
          style: GoogleFonts.rubik(
              textStyle: const TextStyle(color: Colors.white, fontSize: 23)),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: showSearchBar,
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
                  Get.to( StatusTrackerScreen());
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
      body: StreamBuilder<QuerySnapshot>(
        stream: streamMedicinePrice,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.active) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                querySnapshot.docs;

            return ListView.builder(
              itemCount: listQueryDocumentSnapshot.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot document =
                    listQueryDocumentSnapshot[index];
                return Column(
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top:8,bottom: 8),
                        child: ListTile(
                          title: Text(
                            (document['name']as String).toUpperCase(),
                            style: const TextStyle(
                                letterSpacing: 1,
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 1,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Generic : ',
                                    style: TextStyle(
                                        letterSpacing: 0.2,
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    document['group'],
                                    style: const TextStyle(
                                        letterSpacing: 0.2,
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const Text(
                                        'Qty : ',
                                        style: TextStyle(
                                            letterSpacing: 0.2,
                                            color: Colors.black87,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        document['qty'],
                                        style: const TextStyle(
                                            letterSpacing: 0.2,
                                            color: Colors.black87,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Strengths : ',
                                    style: TextStyle(
                                        letterSpacing: 0.2,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    document['mg'],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const Text(
                                        'Price : ',
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            letterSpacing: 0.2,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        document['price'],
                                        style: const TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build and display search results here
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: kPrimaryColor, // Set your primary color here
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: Colors.white, // Set icon color to white
      ), // Ensure contrast with white icons
      primaryTextTheme: theme.textTheme,
    );
  }
}

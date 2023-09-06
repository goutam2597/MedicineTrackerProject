import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/pages/bottom_nav/status_tracker_screen.dart';
import 'package:medicine_reminder/pages/bottom_nav/nearby_medicine_store_screen.dart';
import 'package:medicine_reminder/pages/bottom_nav/price_tracker.dart';
import 'package:medicine_reminder/pages/home_page.dart';
import 'package:medicine_reminder/pages/new_entry/new_entry_page.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    StatusTrackerScreen(),
    const PriceTrackerScreen(),
    const NearbyMedicineStoreScreen(),
  ];

  Widget selectedScreen = const HomePage();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,size: 40,),
        onPressed: () {
          Get.to(const NewEntryPage());
        },
        backgroundColor: const Color(0xff45B3CB),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageStorage(
        child: selectedScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8,top:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          selectedScreen = const HomePage();
                          _selectedScreenIndex = 0;
                        },
                      );
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _selectedScreenIndex == 0 ? kShadowColor : Colors.white,// You can set the background color here
                      ),
                      child: Icon(
                        Icons.dashboard,
                        color: _selectedScreenIndex == 0 ? const Color(0xff45B3CB) : Colors.grey,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        selectedScreen = StatusTrackerScreen();
                        _selectedScreenIndex = 1;
                      },
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _selectedScreenIndex == 1 ? kShadowColor : Colors.white,// You can set the background color here
                    ),
                    child: Icon(
                      Icons.add_chart,
                      color: _selectedScreenIndex == 1 ? const Color(0xff45B3CB) : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),
                GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        selectedScreen = const PriceTrackerScreen();
                        _selectedScreenIndex = 2;
                      },
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _selectedScreenIndex == 2 ? kShadowColor : Colors.white,// You can set the background color here
                    ),
                    child: Icon(
                      Icons.currency_exchange_outlined,
                      color: _selectedScreenIndex == 2 ? const Color(0xff45B3CB) : Colors.grey,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        selectedScreen = const NearbyMedicineStoreScreen();
                        _selectedScreenIndex = 3;
                      },
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _selectedScreenIndex == 3 ? kShadowColor : Colors.white,// You can set the background color here
                    ),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: _selectedScreenIndex == 3 ? const Color(0xff45B3CB) : Colors.grey,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

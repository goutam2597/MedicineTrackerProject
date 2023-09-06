import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/global_bloc.dart';
import 'package:medicine_reminder/models/medicine.dart';
import 'package:medicine_reminder/pages/drawer_screens/about_us_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/ambulance_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/buy_medicine_online_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/first_aids_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/medicine_donation_networks.dart';
import 'package:medicine_reminder/pages/drawer_screens/medicine_side_effects_screen.dart';
import 'package:medicine_reminder/pages/medicine_details/medicine_details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Uri dialNumber = Uri(scheme: 'tel',path: '12345678901');

  callNumber()async{
    await launchUrl(dialNumber);
  }


  int totalDose = 0;
  int dailyDose = 0;
  int remainingDose = 0;
  int remainingDays = 0;

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
        remainingDose = totalDose - _getTakenDoseCount(prefs);
        remainingDays = (remainingDose / dailyDose).ceil();
      });
    } catch (e) {
      log("Error loading data from SharedPreferences: $e" as num);
    }
  }

  int _getTakenDoseCount(SharedPreferences prefs) {
    int takenCount = 0;
    for (int i = 0; i < totalDose; i++) {
      final isTaken = prefs.getBool('day_$i') ?? false;
      if (isTaken) {
        takenCount++;
      }
    }
    return takenCount;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medicine Tracker',
          style: GoogleFonts.rubik(textStyle: const TextStyle(color: Colors.white, fontSize: 23)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff45B3CB),
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.magnifyingGlass,size: 23,)),
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
                  Get.to(MedicineDonationNetworks());
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
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopContainer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Total Doses: $totalDose',style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: kPrimaryColor),),
                const SizedBox(height: 5,),
                Text('Remaining Doses: $remainingDose',style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: kPrimaryColor),),
                const SizedBox(height: 5,),
                Text('Remaining Days: $remainingDays',style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: kPrimaryColor),),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            const Flexible(
              child: BottomContainer(),
            ),
          ],
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 1.h,
          ),
          child: const Text(
            'Worry less. \nLive healthier.',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 1.h),
          child: const Text(
            'Welcome to Daily Dose.',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 18),
          ),
        ),

        SizedBox(
          height: 2.h,
        ),
        //lets show number of saved medicines from shared preferences
        // StreamBuilder<List<Medicine>>(
        //     stream: globalBloc.medicineList$,
        //     builder: (context, snapshot) {
        //       return Container(
        //         alignment: Alignment.center,
        //         padding: EdgeInsets.only(bottom: 1.h),
        //         child: Text(
        //           !snapshot.hasData ? '0' : snapshot.data!.length.toString(),
        //           style: const TextStyle(
        //               fontSize: 50,
        //               color: kPrimaryColor,
        //               fontWeight: FontWeight.bold),
        //         ),
        //       );
        //     }),
      ],
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return StreamBuilder(
      stream: globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          //if no data is saved
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No Medicine',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          );
        } else {
          return GridView.builder(
            padding: EdgeInsets.only(top: 1.h),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return MedicineCard(medicine: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({Key? key, required this.medicine}) : super(key: key);
  final Medicine medicine;

  Hero makeIcon(double size) {
    if (medicine.medicineType == 'Bottle') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/bottle.svg',
          height: 7.h,
          color: Colors.white,
        ),
      );
    } else if (medicine.medicineType == 'Pill') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/pill.svg',
          height: 7.h,
          color: Colors.white,
        ),
      );
    } else if (medicine.medicineType == 'Syringe') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/syringe.svg',
          height: 7.h,
          color: Colors.white,
        ),
      );
    } else if (medicine.medicineType == 'Tablet') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/tablet.svg',
          height: 7.h,
          color: Colors.white,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName! + medicine.medicineType!,
      child: Icon(
        Icons.error,
        color: Colors.white,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.grey,
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder<void>(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, Widget? child) {
                  return Opacity(
                    opacity: animation.value,
                    child: MedicineDetails(medicine),
                  );
                },
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
        margin: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: kShadowBgColor,
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            makeIcon(7.h),
            const Spacer(),
            Hero(
              tag: medicine.medicineName!,
              child: Text(
                medicine.medicineName!,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Text(
              medicine.interval == 1
                  ? "Every ${medicine.interval} hour"
                  : "Every ${medicine.interval} hour",
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

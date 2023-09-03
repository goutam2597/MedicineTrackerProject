import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/global_bloc.dart';
import 'package:medicine_reminder/models/medicine.dart';
import 'package:medicine_reminder/pages/drawer_screens/buy_medicine_online_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/medicine_donation_networks.dart';
import 'package:medicine_reminder/pages/drawer_screens/medicine_tracker_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/nearby_medicine_store_screen.dart';
import 'package:medicine_reminder/pages/drawer_screens/price_tracker.dart';
import 'package:medicine_reminder/pages/medicine_details/medicine_details.dart';
import 'package:medicine_reminder/pages/new_entry/new_entry_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medicine Tracker',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
                    color: Colors.lightBlue,
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
                  style: TextStyle(color: Colors.black54,),
                ),
                leading: const Icon(
                  Icons.add_chart,
                  color: Colors.lightBlue,
                ),
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to(MedicineTrackerScreen());
                },
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Medicine Search',
                  style: TextStyle(color: Colors.black54,),
                ),
                leading: const Icon(
                  Icons.search,
                  color: Colors.lightBlue,
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
                  'Price Tracker',
                  style: TextStyle(color: Colors.black54,),
                ),
                leading: const Icon(
                  Icons.currency_exchange_outlined,
                  color: Colors.lightBlue,
                ),
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
                  style: TextStyle(color: Colors.black54,),
                ),
                leading: const Icon(
                  Icons.error,
                  color: Colors.lightBlue,
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
                  style: TextStyle(color: Colors.black54,),
                ),
                leading: const Icon(
                  Icons.local_convenience_store,
                  color: Colors.lightBlue,
                ),
                horizontalTitleGap: 0,
                onTap: (){Get.to(const NearbyMedicineStoreScreen());}
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Buy Medicine Online',
                  style: TextStyle(color: Colors.black54,),
                ),
                leading: const Icon(
                  Icons.local_grocery_store,
                  color: Colors.lightBlue,
                ),
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to(BuyMedicineOnline());
                },
              ),
              const Divider(
                thickness: 1,
                height: 8,
              ),
              ListTile(
                title: const Text(
                  'Medication Donation Network',
                  style: TextStyle(color: Colors.black54,),
                ),
                leading: const FaIcon(
                  FontAwesomeIcons.handHoldingMedical,
                  color: Colors.lightBlue,
                ),
                horizontalTitleGap: 0,
                onTap: () {Get.to(MedicineDonationNetworks());},
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
                  style: TextStyle(color: Colors.lightBlue,),
                ),
                leading: const Icon(
                  Icons.info,
                  color: Colors.lightBlue,
                ),
                horizontalTitleGap: 0,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            const TopContainer(),
            SizedBox(
              height: 2.h,
            ),
            const Flexible(
              child: BottomContainer(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewEntryPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 1.h,
          ),
          child: Text(
            'Worry less. \nLive healthier.',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 1.h),
          child: const Text(
            'Welcome to Daily Dose.',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        //lets show number of saved medicines from shared preferences
        StreamBuilder<List<Medicine>>(
            stream: globalBloc.medicineList$,
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 1.h),
                child: Text(
                  !snapshot.hasData ? '0' : snapshot.data!.length.toString(),
                  style: const TextStyle(
                      fontSize: 50,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold),
                ),
              );
            }),
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
          color: Colors.lightBlue,
        ),
      );
    } else if (medicine.medicineType == 'Pill') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/pill.svg',
          height: 7.h,
          color: Colors.lightBlue,
        ),
      );
    } else if (medicine.medicineType == 'Syringe') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/syringe.svg',
          height: 7.h,
          color: Colors.lightBlue,
        ),
      );
    } else if (medicine.medicineType == 'Tablet') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/tablet.svg',
          height: 7.h,
          color: Colors.lightBlue,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName! + medicine.medicineType!,
      child: Icon(
        Icons.error,
        color: kOtherColor,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            //call the function here icon type
            //later we will the icon issue
            makeIcon(7.h),
            const Spacer(),
            //hero tag animation, later
            Hero(
              tag: medicine.medicineName!,
              child: Text(
                medicine.medicineName!,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            //time interval data with condition, later
            Text(
              medicine.interval == 1
                  ? "Every ${medicine.interval} hour"
                  : "Every ${medicine.interval} hour",
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

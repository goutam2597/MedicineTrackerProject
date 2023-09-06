import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/pages/bottom_nav_base.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class FabFormField extends StatefulWidget {
  const FabFormField({super.key});

  @override
  _FabFormFieldState createState() => _FabFormFieldState();
}

class _FabFormFieldState extends State<FabFormField> {
  int totalDose = 0;
  int dailyDose = 0;

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  void loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalDose = prefs.getInt('totalDose') ?? 0;
      dailyDose = prefs.getInt('dailyDose') ?? 0;
    });
  }

  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('totalDose', totalDose);
    prefs.setInt('dailyDose', dailyDose);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Dose Count'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(2.h),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Number of Doses',
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor),
              ),),
            const SizedBox(
              height: 5,
            ),

            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Total Doses'),
              onChanged: (value) {
                setState(() {
                  totalDose = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Text('Daily Dose Count',
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor),
              ),),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Daily Dose'),
              onChanged: (value) {
                setState(() {
                  dailyDose = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  saveData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBaseScreen(),
                      settings: RouteSettings(
                        arguments: {
                          'totalDose': totalDose,
                          'dailyDose': dailyDose,
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Save',style: TextStyle(fontSize: 20),),
              ),
            )

          ],
        ),
      ),
    );
  }
}

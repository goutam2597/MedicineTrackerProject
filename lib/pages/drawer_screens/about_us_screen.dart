import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/constants.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.rubik(
              textStyle: const TextStyle(color: Colors.white, fontSize: 23)),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
                child: Image.asset(
              'assets/logo/logo.png',
              height: 120,
            )),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Medicine Tracker',
              style: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w600)),
            ),
            const Divider(
              thickness: 1,
              color: kPrimaryColor,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Medicine Tracker app is a smartphone application that assists users in "
              "managing their medication schedules and health routines. These apps provide timely "
              "reminders for medication intake, helping users stay compliant with their prescriptions."
              " They often include databases with information about various medications, making it easier"
              " to input and track specific drug regimens. Additionally, users can monitor their medication "
              "supplies and receive alerts for refills. Many of these apps also offer valuable health insights, "
              "helping individuals maintain a better understanding of their overall well-being.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15.5),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Meet Our Team',
              style: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
              )),
            ),
            const Divider(
              thickness: 1,
              color: kPrimaryColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Image.asset('assets/images/gk.jpg'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Goutam Sharma',style: TextStyle(fontWeight: FontWeight.w500),),
                        const SizedBox(height: 3,),
                        Row(
                          children: [
                            GestureDetector(onTap:(){}, child: const FaIcon(FontAwesomeIcons.github,color: kPrimaryColor,)),
                            const SizedBox(width: 16,),
                            GestureDetector(onTap:(){}, child: const FaIcon(FontAwesomeIcons.linkedin,color: kPrimaryColor,)),
                            const SizedBox(width: 16,),
                            GestureDetector(onTap:(){}, child: const FaIcon(FontAwesomeIcons.facebook,color: kPrimaryColor,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Image.asset('assets/images/topu.png'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Arafat Bin Sidici',style: TextStyle(fontWeight: FontWeight.w500),),
                        const SizedBox(height: 3,),
                        Row(
                          children: [
                            GestureDetector(onTap:(){}, child: const FaIcon(FontAwesomeIcons.github,color: kPrimaryColor,)),
                            const SizedBox(width: 16,),
                            GestureDetector(onTap:(){}, child: const FaIcon(FontAwesomeIcons.linkedin,color: kPrimaryColor,)),
                            const SizedBox(width: 16,),
                            GestureDetector(onTap:(){}, child: const FaIcon(FontAwesomeIcons.facebook,color: kPrimaryColor,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration:  BoxDecoration(
                    border: Border.all(width: 1,color: kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Image.asset('assets/images/tj.png'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Maliha Tanjum',style: TextStyle(fontWeight: FontWeight.w500),),
                        const SizedBox(height: 3,),
                        Row(
                          children: [
                            GestureDetector(onTap:(){}, child: const FaIcon(FontAwesomeIcons.github,color: kPrimaryColor,)),
                            const SizedBox(width: 16,),
                            GestureDetector(onTap:(){}, child: const FaIcon(FontAwesomeIcons.linkedin,color: kPrimaryColor,)),
                            const SizedBox(width: 16,),
                            GestureDetector(onTap:(){}, child: const FaIcon(FontAwesomeIcons.facebook,color: kPrimaryColor,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

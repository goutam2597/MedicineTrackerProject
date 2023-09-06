import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicineDonationNetworks extends StatelessWidget {
  MedicineDonationNetworks({super.key});

  final Uri _dam = Uri.parse('https://www.ahsaniamission.org.bd/');
  final Uri _crp = Uri.parse('https://www.crp-bangladesh.org/');

  Future<void> _launchUrldam() async {
    if (!await launchUrl(_dam)) {
      throw Exception('Could not launch $_dam');
    }
  }

  Future<void> _launchUrlcrp() async {
    if (!await launchUrl(_crp)) {
      throw Exception('Could not launch $_crp');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Donation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _launchUrldam,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.00),
                                child: Text(
                                  'Ahsaniamission.org.bd >',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.00),
                                  child: Image.asset(
                                    'assets/ecomlogo/dam.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _launchUrlcrp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.00),
                                child: Text(
                                  'Crp-Bangladesh.org >',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.00),
                                  child: Image.asset(
                                    'assets/ecomlogo/crp.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

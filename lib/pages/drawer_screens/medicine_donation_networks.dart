import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/pages/drawer_screens/webviews/yib_webview.dart';

class MedicineDonationNetworks extends StatelessWidget {
  const MedicineDonationNetworks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medicine Donation Networks'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24,right: 24,top: 24),
            child: GestureDetector(
              onTap: (){
                Get.to(YibWebView());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.00),
                    child: Text(
                      'Yibd.org >',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.00),
                      child: Image.network('https://shorturl.at/lzU56',fit: BoxFit.cover,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

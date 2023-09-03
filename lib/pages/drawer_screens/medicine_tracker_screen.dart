import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MedicineTrackerScreen extends StatelessWidget {
  const MedicineTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {

    DateTime today = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: Text('Medicine Tracker'),),
      body: Column(
        children: [
          Container(
            child: TableCalendar(
              focusedDay: today,
              firstDay: DateTime.utc(2000,01,01),
              lastDay: DateTime.utc(2023, 12, 31),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/constants.dart';
import 'package:medicine_reminder/global_bloc.dart';
import 'package:medicine_reminder/models/errors.dart';
import 'package:medicine_reminder/models/medicine.dart';
import 'package:medicine_reminder/pages/home_page.dart';
import 'package:medicine_reminder/pages/new_entry/new_entry_bloc.dart';
import 'package:medicine_reminder/pages/success_screen/success_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../../common/convert_time.dart';
import '../../models/medicine_type.dart';
import 'package:timezone/timezone.dart' as tz;

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({Key? key}) : super(key: key);

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  BuildContext? _scaffoldContext;
  late TextEditingController nameController;
  late TextEditingController dosageController;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late NewEntryBloc _newEntryBloc;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _newEntryBloc = NewEntryBloc();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeNotifications();
    initializeErrorListen();
    loadSavedData();
  }

  int totalDose = 0;
  int dailyDose = 0;

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
    _scaffoldContext = context;
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add New'),
      ),
      body: SingleChildScrollView(
        child: Provider<NewEntryBloc>.value(
          value: _newEntryBloc,
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Medicine Name',
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
                  maxLength: 12,
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(hintText: 'Name'),
                  style: const TextStyle(fontSize: 18),
                ),
                Text('Strength',
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kPrimaryColor),
                    )),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  maxLength: 12,
                  controller: dosageController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Dosage in mg'),
                  style: const TextStyle(fontSize: 18),
                ),
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
                  style: const TextStyle(fontSize: 18),
                  onChanged: (value) {
                    setState(() {
                      totalDose = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                const SizedBox(
                  height: 18,
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
                  style: const TextStyle(fontSize: 18),
                  onChanged: (value) {
                    setState(() {
                      dailyDose = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                Text('Medicine Type',
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kPrimaryColor),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: StreamBuilder<MedicineType>(
                    stream: _newEntryBloc.selectedMedicineType,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //not yet clickable?
                          MedicineTypeColumn(
                              medicineType: MedicineType.Bottle,
                              name: 'Bottle',
                              iconValue: 'assets/icons/bottle.svg',
                              isSelected: snapshot.data == MedicineType.Bottle
                                  ? true
                                  : false),
                          MedicineTypeColumn(
                              medicineType: MedicineType.Pill,
                              name: 'Pill',
                              iconValue: 'assets/icons/pill.svg',
                              isSelected: snapshot.data == MedicineType.Pill
                                  ? true
                                  : false),
                          MedicineTypeColumn(
                              medicineType: MedicineType.Syringe,
                              name: 'Syringe',
                              iconValue: 'assets/icons/syringe.svg',
                              isSelected: snapshot.data == MedicineType.Syringe
                                  ? true
                                  : false),
                          MedicineTypeColumn(
                              medicineType: MedicineType.Tablet,
                              name: 'Tablet',
                              iconValue: 'assets/icons/tablet.svg',
                              isSelected: snapshot.data == MedicineType.Tablet
                                  ? true
                                  : false),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text('Interval Selection',
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kPrimaryColor),
                    )),
                const IntervalSelection(),
                const SizedBox(
                  height: 8,
                ),
                Text('Starting Time',
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kPrimaryColor),
                    )),
                const SelectTime(),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      String? medicineName;
                      int? dosage;

                      if (nameController.text == "") {
                        _newEntryBloc.submitError(EntryError.nameNull);
                        return;
                      }
                      if (nameController.text != "") {
                        medicineName = nameController.text;
                      }
                      if (dosageController.text == "") {
                        dosage = 0;
                      }
                      if (dosageController.text != "") {
                        dosage = int.parse(dosageController.text);
                      }
                      for (var medicine in globalBloc.medicineList$!.value) {
                        if (medicineName == medicine.medicineName) {
                          _newEntryBloc.submitError(EntryError.nameDuplicate);
                          return;
                        }
                      }
                      if (_newEntryBloc.selectIntervals!.value == 0) {
                        _newEntryBloc.submitError(EntryError.interval);
                        return;
                      }
                      if (_newEntryBloc.selectedTimeOfDay$!.value == 'None') {
                        _newEntryBloc.submitError(EntryError.startTime);
                        return;
                      }

                      String medicineType = _newEntryBloc
                          .selectedMedicineType!.value
                          .toString()
                          .substring(13);

                      int interval = _newEntryBloc.selectIntervals!.value;
                      String startTime =
                          _newEntryBloc.selectedTimeOfDay$!.value;

                      List<int> intIDs =
                          makeIDs(24 / _newEntryBloc.selectIntervals!.value);
                      List<String> notificationIDs =
                          intIDs.map((i) => i.toString()).toList();

                      Medicine newEntryMedicine = Medicine(
                          notificationIDs: notificationIDs,
                          medicineName: medicineName,
                          dosage: dosage,
                          medicineType: medicineType,
                          interval: interval,
                          startTime: startTime);

                      globalBloc.updateMedicineList(newEntryMedicine);

                      scheduleNotification(newEntryMedicine);

                      saveData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccessScreen(),
                          settings: RouteSettings(
                            arguments: {
                              'totalDose': totalDose,
                              'dailyDose': dailyDose,
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$!.listen((EntryError error) {
      switch (error) {
        case EntryError.nameNull:
          displayError("Please enter the medicine's name");
          break;

        case EntryError.nameDuplicate:
          displayError("Medicine name already exists");
          break;
        case EntryError.dosage:
          displayError("Please enter the dosage required");
          break;
        case EntryError.interval:
          displayError("Please select the reminder's interval");
          break;
        case EntryError.startTime:
          displayError("Please select the reminder's starting time");
          break;
        default:
      }
    });
  }

  void displayError(String error) {
    Get.snackbar(
      'Ops!',
      'Error.',
      colorText: kSnackBarColor,
      messageText: Text(
        error,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: kSnackBarColor,
        ),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    try {
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      );
      print("Notifications initialized successfully.");
    } catch (e) {
      print("Error initializing notifications: $e");
    }
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Future<void> scheduleNotification(Medicine medicine) async {
    var hour = int.parse(medicine.startTime![0] + medicine.startTime![1]);
    var minute = int.parse(medicine.startTime![2] + medicine.startTime![3]);

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'repeatDailyAtTime channel id', 'repeatDailyAtTime channel name',
        importance: Importance.max,
        ledColor: kOtherColor,
        ledOffMs: 1000,
        ledOnMs: 1000,
        enableLights: true);

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    var now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute, 0);

    for (int i = 0; i < (24 / medicine.interval!).floor(); i++) {
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse(medicine.notificationIDs![i]),
        'Reminder: ${medicine.medicineName}',
        medicine.medicineType.toString() != MedicineType.None.toString()
            ? 'It is time to take your ${medicine.medicineType!.toLowerCase()}, according to schedule'
            : 'It is time to take your medicine, according to schedule',
        scheduledDate,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      scheduledDate = scheduledDate.add(Duration(hours: medicine.interval!));
    }
    if (_scaffoldContext != null) {
      Get.snackbar(
        'Congratulations!',
        'Scheduled notifications for ${medicine.medicineName}',
        colorText: kPrimaryColor,
        messageText: Text(
          'Scheduled notifications for ${medicine.medicineName}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: kPrimaryColor,
          ),
        ),
      );
    }
  }
}


class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay?> _selectTime() async {
    final NewEntryBloc newEntryBloc =
        Provider.of<NewEntryBloc>(context, listen: false);

    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;

        //update state via provider, we will do later
        newEntryBloc.updateTime(convertTime(_time.hour.toString()) +
            convertTime(_time.minute.toString()));
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: ElevatedButton(
          onPressed: () {
            _selectTime();
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "Select Time"
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({Key? key}) : super(key: key);

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remind me every',
            style: GoogleFonts.rubik(
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor),
            ),
          ),
          DropdownButton(
            iconEnabledColor: kOtherColor,
            dropdownColor: kScaffoldColor,
            itemHeight: 8.h,
            hint: _selected == 0
                ? Text(
                    'Select Interval',
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                  )
                : null,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            items: _intervals.map(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style:GoogleFonts.rubik(
                  textStyle: const TextStyle(
                  fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
                  ),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(
                () {
                  _selected = newVal!;
                  newEntryBloc.updateInterval(newVal);
                },
              );
            },
          ),
          Text(
            _selected == 1 ? " hour" : " hours",
            style: GoogleFonts.rubik(
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn(
      {Key? key,
      required this.medicineType,
      required this.name,
      required this.iconValue,
      required this.isSelected})
      : super(key: key);
  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        newEntryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.h),
                color: isSelected ? kOtherColor : Colors.white),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 1.h,
                  bottom: 1.h,
                ),
                child: SvgPicture.asset(
                  iconValue,
                  height: 7.h,
                  color: isSelected ? Colors.white : kOtherColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 20.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isSelected ? kOtherColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: isSelected ? Colors.white : kOtherColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({Key? key, required this.title, required this.isRequired})
      : super(key: key);
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: isRequired ? " *" : "",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: kPrimaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

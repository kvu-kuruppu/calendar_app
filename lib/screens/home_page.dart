import 'package:calendar_app/consts/routes.dart';
import 'package:calendar_app/services/notification_service.dart';
import 'package:calendar_app/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as devtools show log;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var notif;

  @override
  void initState() {
    super.initState();
    notif = Notif();
    notif.initializeNotification();
    notif.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 202, 202),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 202, 202, 202),
        elevation: 0,
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () {
              notif.displayNotification(
                title: 'Hehe',
                body: 'body',
              );
              notif.scheduledNotification();
            },
            icon: const Icon(
              Icons.person,
              size: 15,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                MyButton(
                  label: '+ Add Task',
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      addTaskRoute,
                      // (route) => false,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Color.fromARGB(255, 12, 103, 179),
              selectedTextColor: Colors.white,
              dateTextStyle: const TextStyle(
                fontSize: 35,
                color: Colors.grey,
              ),
              dayTextStyle: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
              monthTextStyle: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
              onDateChange: (date) {
                _selectedDate = date;
              },
            ),
          ],
        ),
      ),
    );
  }
}

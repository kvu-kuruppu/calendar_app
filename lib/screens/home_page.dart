import 'package:calendar_app/consts/routes.dart';
import 'package:calendar_app/controller/task_controller.dart';
import 'package:calendar_app/models/task.dart';
import 'package:calendar_app/utils/holiday_info.dart';
import 'package:calendar_app/widgets/button.dart';
import 'package:calendar_app/widgets/holiday_tile.dart';
import 'package:calendar_app/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectDate = DateTime.now();
  final _taskController = Get.put(TaskController());


  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 202, 202),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // Date
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          // Today
                          'Today',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Add Task
                    MyButton(
                      label: '+ Add Task',
                      onPressed: () async {
                        await Navigator.of(context).pushNamed(
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
                // Calendar
                SfCalendar(
                  view: CalendarView.month,
                  firstDayOfWeek: 1,
                  selectionDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  onTap: calendarTapped,
                ),
                // DatePicker(
                //   DateTime.now(),
                //   height: 100,
                //   width: 80,
                //   initialSelectedDate: DateTime.now(),
                //   selectionColor: const Color.fromARGB(255, 12, 103, 179),
                //   selectedTextColor: Colors.white,
                //   dateTextStyle: const TextStyle(
                //     fontSize: 35,
                //     color: Colors.grey,
                //   ),
                //   dayTextStyle: const TextStyle(
                //     fontSize: 15,
                //     color: Colors.grey,
                //   ),
                //   monthTextStyle: const TextStyle(
                //     fontSize: 15,
                //     color: Colors.grey,
                //   ),
                //   onDateChange: (date) {
                //     setState(() {
                //       _selectDate = date;
                //     });
                //   },
                // ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Holidays',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _showHolidays(),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          _showTasks(),
        ],
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    details.targetElement == CalendarElement.calendarCell;
    setState(() {
      _selectDate = details.date!;
    });
    print(DateFormat.yMd().format(details.date!));
  }

  _showHolidays() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: holidayList
            .map((holiday) => HolidayTile(holiday: holiday))
            .toList(),
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              if (task.repeat == 'Daily') {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showSimpleDialog(index);
                            },
                            child: TaskTile(
                              _taskController.taskList[index],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showSimpleDialog(index);
                            },
                            child: TaskTile(
                              _taskController.taskList[index],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _showSimpleDialog(index) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text(
              'Are you sure want to delete?',
              textAlign: TextAlign.center,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Delete Button
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: SimpleDialogOption(
                      onPressed: () async {
                        await _taskController
                            .deleteTasks(_taskController.taskList[index])
                            .then(
                          (value) {
                            Navigator.of(context).pop();
                            _taskController.getTasks();
                            print(value.toString());
                          },
                        );
                      },
                      child: const Text(
                        'Delete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Cancel Button
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: SimpleDialogOption(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}

import 'dart:async';

import 'package:calendar_app/controller/task_controller.dart';
import 'package:calendar_app/models/task.dart';
import 'package:calendar_app/utils/show_error_dialog.dart';
import 'package:calendar_app/widgets/button.dart';
import 'package:calendar_app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as devtools show log;
import 'package:get/get.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TaskController _taskController = Get.put(TaskController());
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectDate = DateTime.now();
  TimeOfDay _endTime = TimeOfDay.now();
  TimeOfDay _startTime = TimeOfDay.now();
  // String _endTimee = '9:30 PM';
  // String _startTimee = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _selectReminder = '15 min before';
  List<String> remindList = [
    '15 min before',
    '1 hour before',
    '1 day before',
  ];
  String _selectRepeat = 'None';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 202, 202),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: const Color.fromARGB(255, 202, 202, 202),
          elevation: 0,
          toolbarHeight: kToolbarHeight,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Task
              const Text(
                'Add Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Title
              InputField(
                title: 'Title',
                hint: 'Enter your title',
                controller: _titleController,
              ),
              // Note
              InputField(
                title: 'Note',
                hint: 'Enter your note',
                controller: _noteController,
              ),
              // Date
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectDate),
                widget: IconButton(
                  onPressed: () async {
                    DateTime? _pickDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2999),
                    );
                    if (_pickDate != null) {
                      setState(() {
                        _selectDate = _pickDate;
                      });
                    } else {
                      devtools.log('Date is not selected');
                    }
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 94, 93, 93),
                  ),
                ),
              ),
              Row(
                children: [
                  // Start Time
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime.format(context),
                      // hint: _startTimee,
                      widget: IconButton(
                        // onPressed: () {
                        //   _getTimeFromUser(isStartTime: true);
                        // },
                        onPressed: () async {
                          TimeOfDay? _pickTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (_pickTime != null) {
                            setState(() {
                              _startTime = _pickTime;
                            });
                          } else {
                            devtools.log('Time is not selected');
                          }
                        },
                        icon: const Icon(
                          Icons.access_time,
                          color: Color.fromARGB(255, 94, 93, 93),
                        ),
                      ),
                    ),
                  ),
                  // End Time
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime.format(context),
                      // hint: _endTimee,
                      widget: IconButton(
                        // onPressed: () {
                        //   _getTimeFromUser(isStartTime: false);
                        // },
                        onPressed: () async {
                          TimeOfDay? _pickTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (_pickTime != null) {
                            setState(() {
                              _endTime = _pickTime;
                            });
                          } else {
                            devtools.log('Time is not selected');
                          }
                        },
                        icon: const Icon(
                          Icons.access_time,
                          color: Color.fromARGB(255, 94, 93, 93),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Remind
              InputField(
                title: 'Remind',
                hint: _selectReminder,
                widget: DropdownButton(
                  dropdownColor: const Color.fromARGB(255, 202, 202, 202),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 94, 93, 93),
                  ),
                  items: remindList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectReminder = newValue!;
                    });
                  },
                ),
              ),
              // Repeat
              InputField(
                title: 'Repeat',
                hint: _selectRepeat,
                widget: DropdownButton(
                  dropdownColor: const Color.fromARGB(255, 202, 202, 202),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 94, 93, 93),
                  ),
                  items: repeatList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectRepeat = newValue!;
                    });
                  },
                ),
              ),
              // Create Task
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    label: 'Create Task',
                    onPressed: () {
                      if (_noteController.text.isNotEmpty &&
                          _titleController.text.isNotEmpty) {
                        Timer(
                          const Duration(seconds: 1),
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                        _addTaskToDb();
                        _taskController.getTasks();
                      } else {
                        showErrorDialog(context, 'All fields  are required');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _getTimeFromUser({required bool isStartTime}) {
  //   var pickedTime = _showTimePicker();
  //   String _formattedTime = pickedTime.format(context);
  //   if (pickedTime == null) {
  //     print('Time not selected');
  //   } else if (isStartTime == true) {
  //     _startTimee = _formattedTime;
  //   } else if (isStartTime == false) {
  //     _endTimee = _formattedTime;
  //   }
  // }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(hour: 9, minute: 10));
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectDate),
        startTime: _startTime.format(context),
        endTime: _endTime.format(context),
        remind: _selectReminder,
        repeat: _selectRepeat,
        isCompleted: 0,
      ),
    );
  }
}

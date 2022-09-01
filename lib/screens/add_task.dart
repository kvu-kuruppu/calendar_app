import 'package:calendar_app/consts/routes.dart';
import 'package:calendar_app/widgets/button.dart';
import 'package:calendar_app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as devtools show log;

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectDate = DateTime.now();
  TimeOfDay _selectTime = TimeOfDay.now();
  int _selectReminder = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _selectRepeat = 'None';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 202, 202),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
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
              const InputField(
                title: 'Title',
                hint: 'Enter your title',
              ),
              const InputField(
                title: 'Note',
                hint: 'Enter your note',
              ),
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
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _selectTime.format(context),
                      widget: IconButton(
                        onPressed: () async {
                          TimeOfDay? _pickTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (_pickTime != null) {
                            setState(() {
                              _selectTime = _pickTime;
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
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _selectTime.format(context),
                      widget: IconButton(
                        onPressed: () async {
                          TimeOfDay? _pickTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (_pickTime != null) {
                            setState(() {
                              _selectTime = _pickTime;
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
              InputField(
                title: 'Remind',
                hint: '${_selectReminder} min early',
                widget: DropdownButton(
                  dropdownColor: Color.fromARGB(255, 202, 202, 202),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 94, 93, 93),
                  ),
                  items: remindList.map<DropdownMenuItem<String>>(
                    (int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectReminder = int.parse(newValue!);
                    });
                  },
                ),
              ),
              InputField(
                title: 'Repeat',
                // hint: '${_selectRepeat} min early',
                hint: _selectRepeat,
                widget: DropdownButton(
                  dropdownColor: Color.fromARGB(255, 202, 202, 202),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    label: 'Create Task',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

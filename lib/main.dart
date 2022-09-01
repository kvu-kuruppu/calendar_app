import 'package:calendar_app/consts/routes.dart';
import 'package:calendar_app/screens/add_task.dart';
import 'package:calendar_app/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar',
      home: const HomePage(),
      routes: {
        addTaskRoute: (context) => const AddTaskView(),
        homePageRoute: (context) => const HomePage(),
      },
    ),
  );
}

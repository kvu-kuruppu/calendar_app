import 'package:calendar_app/consts/routes.dart';
import 'package:calendar_app/db/db_helper.dart';
import 'package:calendar_app/screens/add_task.dart';
import 'package:calendar_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DBHelper.initDb();
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


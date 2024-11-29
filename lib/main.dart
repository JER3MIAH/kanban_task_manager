import 'package:flutter/material.dart';
import 'package:kanban_task_manager/src/app.dart';
import 'package:kanban_task_manager/src/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Future.delayed(const Duration(milliseconds: 600));
  runApp(const MyApp());
}

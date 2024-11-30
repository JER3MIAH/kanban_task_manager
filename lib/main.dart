import 'package:flutter/material.dart';
import 'package:kanban_task_manager/src/app.dart';
import 'package:kanban_task_manager/src/app_injection_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  AppInjectionContainer.init();
  await Future.delayed(const Duration(milliseconds: 600));
  runApp(const MyApp());
}

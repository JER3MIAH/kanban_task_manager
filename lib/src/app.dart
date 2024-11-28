import 'package:flutter/material.dart';
import 'features/theme/data/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanban Task Manager',
      theme: lightTheme,
    );
  }
}

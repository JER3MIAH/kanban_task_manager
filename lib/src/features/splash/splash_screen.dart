import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/navigation/nav.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = AppNavigator(context);

    useEffect(() {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => navigator.replaceAllNamed(AppRoutes.home),
      );
      return null;
    }, const []);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(),
      ),
    );
  }
}

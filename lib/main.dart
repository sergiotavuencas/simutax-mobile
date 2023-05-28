// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/screens/startup_screen.dart';
import 'package:simutax_mobile/theme/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simutax',
      routes: AppRoutes.define(),
      home: const StartupScreen(),
      theme: Style().appTheme(context),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/screens/login_screen.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StartupScreenViewState();
}

class _StartupScreenViewState extends State<StartupScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  dynamic sum = 0;
  String progress = '0 %';

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 11),
    )..addListener(
        () {
          setState(() {});
        },
      );
    controller.repeat(reverse: false);
    super.initState();

    Future.delayed(const Duration(seconds: 11), () {
      controller.dispose();
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (controller.isAnimating) {
        setState(() {
          if (sum < 100) {
            sum += 10;
            progress = "$sum %";
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppStyle appStyle = AppStyle(context);

    final appLogo = ClipRect(
      child: Image.asset(
        "lib/resources/simutax-mobile-logo.png",
        width: appStyle.width / 1.3,
        height: appStyle.height / 3.5,
        // fit: BoxFit.cover,
      ),
    );

    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        height: double.maxFinite,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/resources/simutax-background.png"),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: appStyle.height / 12, left: 20),
                child: Text("By Error404", style: appStyle.groupStyle),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: appStyle.height / 3),
                child: appLogo,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: appStyle.height / 30),
                child: Text(progress, style: appStyle.progressStyle),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator(
                value: controller.value,
                minHeight: 15,
                color: appStyle.yellow,
                backgroundColor: appStyle.darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

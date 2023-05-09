import 'package:flutter/material.dart';
import 'package:simutax_front/routes.dart';
import 'package:simutax_front/theme/app_style.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StartupScreenViewState();
}

class _StartupScreenViewState extends State<StartupScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(AppRoutes.loginScreen);
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
      body: Center(
        child: Column(
          children: [
            appLogo,
            const CircularProgressIndicator(
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitWave(
          size: 140,
          color: appStyle.darkBlue,
          itemCount: 14,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class ShutProfileScreen extends StatefulWidget {
  const ShutProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ShutProfileScreenViewState();
}

class _ShutProfileScreenViewState extends State<ShutProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final yesButton = ElevatedButton(
      onPressed: () async {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushNamed(AppRoutes.pixPaymentScreen);
        });
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Text(
        "Sim",
        style: appStyle.buttonStyleBlue,
      ),
    );

    final noButton = ElevatedButton(
      onPressed: () async {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushNamed(AppRoutes.pixPaymentScreen);
        });
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Text(
        "Não",
        style: appStyle.buttonStyleBlue,
      ),
    );

    final buttonsContainer = SizedBox(
      width: appStyle.width / 1.1,
      child: Column(
        children: [yesButton, noButton]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 60),
                  child: widget,
                ))
            .toList(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Conta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 95, 95, 95)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "Encerra conta?",
                    style: GoogleFonts.dmSans(
                      fontSize: appStyle.xxLarge,
                      fontWeight: FontWeight.w900,
                      color: appStyle.darkBlue,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: buttonsContainer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

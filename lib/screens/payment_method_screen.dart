import 'package:flutter/material.dart';
import 'package:simutax_front/routes.dart';
import 'package:simutax_front/theme/app_style.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentMethodScreenViewState();
}

class _PaymentMethodScreenViewState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final descriptionBox = SizedBox(
      child: Text("Escolha um método de pagamento.",
          style: appStyle.descriptionStyle),
    );

    final rechargeButton = ElevatedButton(
      onPressed: () async {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushNamed(AppRoutes.pixPaymentScreen);
        });
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Pix",
              style: appStyle.buttonStyleBlue,
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          )
        ],
      ),
    );

    final creditCardButton = ElevatedButton(
      onPressed: () async {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushNamed(AppRoutes.creditCardPaymentScreen);
        });
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Cartão de crédito",
              style: appStyle.buttonStyleBlue,
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          )
        ],
      ),
    );

    final buttons = SizedBox(
      height: appStyle.height / 1.35,
      width: appStyle.width / 1.1,
      child: Column(
        children: <Widget>[rechargeButton, creditCardButton]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 60),
                  child: widget,
                ))
            .toList(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recarregar'),
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
                  child: descriptionBox,
                ),
                Padding(
                  padding: EdgeInsets.only(top: appStyle.height / 10),
                  child: buttons,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

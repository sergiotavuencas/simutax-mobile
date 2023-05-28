import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'package:simutax_mobile/theme/widgets/value_to_insert_field.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentMethodScreenViewState();
}

class _PaymentMethodScreenViewState extends State<PaymentMethodScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController valueController = TextEditingController();
  late SharedPreferences prefs;
  late Future<bool> canAdvance;

  double handleValueConvertion() {
    int valueLength = valueController.text.length;
    String convert = valueController.text;

    if (valueLength >= 8) {
      convert = convert.replaceAll(',', '.');
      convert = convert.replaceAll('.', '');
      return double.parse(convert);
    } else {
      return double.parse(convert.replaceAll(',', '.'));
    }
  }

  Future<bool> handleUserLogin(double value) async {
    prefs = await SharedPreferences.getInstance();
    try {
      final String? token = prefs.getString('user_token');
      final api = Uri.parse('http://10.0.2.2:300/api/updateBalance');
      http.Response response = await http.post(api, body: {
        'value': '$value',
      }, headers: {
        'Authorization': 'Bearer $token',
      });
      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        String qrCode = data['message']['qr_code'];
        String qrCodeBase64 = data['message']['qr_code_base64'];
        prefs.setString('qr_code', qrCode);
        prefs.setString('qr_code_base64', qrCodeBase64);

        return true;
      } else if (response.statusCode == 400) {
        prefs.setString(
            'pix_payment_error', 'Erro ao gerar o pagamento por pix');
        return false;
      }
    } catch (error) {
      prefs.setString('pix_payment_error', error.toString());
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final descriptionBox = SizedBox(
      width: appStyle.width / 1.1,
      child: Text(
          'Insira o valor que deseja adicionar a sua carteira, e escolha o método de pagamento de sua preferência.',
          style: appStyle.descriptionStyle),
    );

    final valueField = ValueToInsertField(controller: valueController);

    final valueContainer = SizedBox(
      width: appStyle.width / 1.1,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: appStyle.width / 10,
                  child: Text('R\$', style: appStyle.validValueInputStyle),
                ),
                SizedBox(
                  width: appStyle.width / 3,
                  child: valueField,
                )
              ],
            ),
          ),
        ],
      ),
    );

    final pixButton = ElevatedButton(
      onPressed: () async {
        if (valueController.text != '0,00' && valueController.text != '') {
          double parsedValue = handleValueConvertion();

          if (await handleUserLogin(parsedValue)) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushNamed(context, AppRoutes.pixPaymentScreen);
            });
          } else {
            String? error = prefs.getString('pix_payment_error');
            utils.alert('ERRO: $error');
          }
        } else {
          utils.alert('Insira um valor válido');
        }
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Pix',
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
              'Cartão de crédito',
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
        children: <Widget>[pixButton, creditCardButton]
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
                  padding: EdgeInsets.only(top: appStyle.height / 20),
                  child: descriptionBox,
                ),
                Padding(
                  padding: EdgeInsets.only(top: appStyle.height / 10),
                  child: valueContainer,
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

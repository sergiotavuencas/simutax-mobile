import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/screens/loading_screen.dart';
import 'package:simutax_mobile/screens/pix_payment_screen.dart';
import 'package:simutax_mobile/services/encrypt_data.dart';
import 'package:simutax_mobile/services/payment/payment_services.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'package:simutax_mobile/theme/widgets/value_to_insert_field.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentMethodScreenViewState();
}

class _PaymentMethodScreenViewState extends State<PaymentMethodScreen> {
  late SharedPreferences _prefs;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _valueController = TextEditingController();
  final String _tKey = EncryptData.encryptAES('user_token');
  bool _isLoading = false;
  late String _error;
  // ignore: prefer_final_fields
  Map<String, dynamic> _response = {};

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final descriptionBox = SizedBox(
      width: appStyle.width / 1.1,
      child: Text(
          'Selecione o valor que deseja adicionar a sua carteira para gerar um código pix.',
          style: appStyle.descriptionStyle),
    );

    final valueField = ValueToInsertField(controller: _valueController);

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
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: appStyle.width / 2.5,
                    child: valueField,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

    final pixButton = ElevatedButton(
      onPressed: () async {
        if (_valueController.text != '') {
          _startAnimation();
          if (await _handlePayment()) {
            Future.delayed(const Duration(seconds: 1), () {
              _endAnimation();
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PixPaymentScreen(
                      qrCode: _response['qr_code'],
                      qrCodeBase64: _response['qr_code_base64']),
                ),
              );
            });
          } else {
            _endAnimation();
            utils.alert('ERRO: $_error');
          }
        } else {
          utils.alert('Selecione um valor');
        }
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Efetuar pagamento',
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

/*
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
*/

    final buttons = SizedBox(
      height: appStyle.height / 1.35,
      width: appStyle.width / 1.1,
      child: Column(
        children: <Widget>[
          pixButton,
          // creditCardButton
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 60),
                  child: widget,
                ))
            .toList(),
      ),
    );

    return _isLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Recarregar'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 95, 95, 95)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
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
            ),
          );
  }

  void _startAnimation() async {
    setState(() {
      _isLoading = true;
    });
  }

  void _endAnimation() async {
    setState(() {
      _isLoading = false;
    });
  }

  double _convert() {
    int valueLength = _valueController.text.length;
    String convert = _valueController.text;

    if (valueLength >= 8) {
      convert = convert.replaceAll(',', '.');
      convert = convert.replaceAll('.', '');
      return double.parse(convert);
    } else {
      return double.parse(convert.replaceAll(',', '.'));
    }
  }

  Future<bool> _handlePayment() async {
    bool canAdvance = false;
    _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString(_tKey);
    Map<String, dynamic> data = await PaymentServices().pix({
      'value': '${_convert()}',
    }, {
      'Authorization': 'Bearer $token',
    });

    if (data.containsKey('qr_code') && data.containsKey('qr_code_base64')) {
      _response.addAll({
        'qr_code': data['qr_code'],
        'qr_code_base64': data['qr_code_base64'],
      });

      canAdvance = true;
    } else if (data.containsKey('error')) {
      _error = data['error'];
    }

    return canAdvance;
  }
}

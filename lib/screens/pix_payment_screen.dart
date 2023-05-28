import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class PixPaymentScreen extends StatefulWidget {
  const PixPaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PixPaymentScreenViewState();
}

class _PixPaymentScreenViewState extends State<PixPaymentScreen> {
  late String qrCode;
  late String qrCodeBase64;
  late SharedPreferences prefs;

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  void getPreferences() async {
    prefs = await SharedPreferences.getInstance();
    qrCode = prefs.getString('qr_code')!;
    qrCodeBase64 = prefs.getString('qr_code_base64')!;
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final descriptionBox = SizedBox(
      width: appStyle.width / 1.1,
      child: Text(
          "Escaneie o QRCode generado, ou copie o link para efetuar o pagamento.",
          style: appStyle.descriptionStyle),
    );

    final generatedQRCode = ClipRect(
        child: qrCodeBase64 != ''
            ? Image.memory(base64Decode(qrCodeBase64), scale: 4)
            : null);

    final linkField = SizedBox(
      width: appStyle.width / 1.1,
      height: appStyle.height / 3,
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: qrCode,
          ),
          style: appStyle.inputStyle,
        ),
      ),
    );

    final copyToClipboardButton = SizedBox(
      width: appStyle.width / 1.1,
      child: ElevatedButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: qrCode));
        },
        style: appStyle.createButtonTheme(appStyle.darkBlue),
        child: const Text("Copiar link"),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pix'),
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: descriptionBox,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: generatedQRCode,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: linkField,
                ),
                copyToClipboardButton
              ],
            ),
          ],
        ),
      ),
    );
  }
}

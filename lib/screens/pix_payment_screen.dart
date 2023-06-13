import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';

class PixPaymentScreen extends StatefulWidget {
  const PixPaymentScreen(
      {super.key, required this.qrCode, required this.qrCodeBase64});
  final String qrCode;
  final String qrCodeBase64;

  @override
  State<StatefulWidget> createState() => _PixPaymentScreenViewState();
}

class _PixPaymentScreenViewState extends State<PixPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final descriptionBox = SizedBox(
      width: appStyle.width / 1.1,
      child: Text(
          "Escaneie o QRCode gerado, ou copie o link para efetuar o pagamento.",
          style: appStyle.descriptionStyle),
    );

    final generatedQRCode = ClipRect(
        child: Image.memory(base64Decode(widget.qrCodeBase64), scale: 4));

    final linkField = SizedBox(
      width: appStyle.width / 1.1,
      height: appStyle.height / 6,
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: widget.qrCode,
          ),
          style: appStyle.inputStyle,
        ),
      ),
    );

    final copyToClipboardButton = SizedBox(
      width: appStyle.width / 1.1,
      child: ElevatedButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: widget.qrCode));
          utils.snack('Código copiado!');
        },
        style: appStyle.createButtonTheme(appStyle.darkBlue),
        child: const Text("Copiar código pix"),
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

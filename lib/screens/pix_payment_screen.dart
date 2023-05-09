import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class PixPaymentScreen extends StatefulWidget {
  const PixPaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PixPaymentScreenViewState();
}

class _PixPaymentScreenViewState extends State<PixPaymentScreen> {
  late TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    const String link = "http://y2u.be/dQw4w9WgXcQ";
    linkController.text = link;

    final descriptionBox = SizedBox(
      width: appStyle.width / 1.1,
      child: Text(
          "Escaneie o QRCode generado, ou copie o link para efetuar o pagamento.",
          style: appStyle.descriptionStyle),
    );

    final generatedQRCode = ClipRect(
      child: Image.asset(
        "lib/resources/rickroll.png",
        width: appStyle.width / 1.3,
        height: appStyle.height / 3.5,
        // fit: BoxFit.cover,
      ),
    );

    final linkField = SizedBox(
      width: appStyle.width / 1.1,
      height: appStyle.height / 3,
      child: IgnorePointer(
        child: TextFormField(
          controller: linkController,
          decoration: const InputDecoration(
            hintText: link,
          ),
          style: appStyle.inputStyle,
        ),
      ),
    );

    final copyToClipboardButton = SizedBox(
      width: appStyle.width / 1.1,
      child: ElevatedButton(
        onPressed: () {
          Clipboard.setData(const ClipboardData(text: link));
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

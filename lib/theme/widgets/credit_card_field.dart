import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simutax_mobile/extensions/formatter.dart';
import 'package:simutax_mobile/extensions/string.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class CreditCardField extends StatefulWidget {
  const CreditCardField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _CreditCardFieldState();
}

class _CreditCardFieldState extends State<CreditCardField> {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return TextFormField(
      controller: widget.controller,
      validator: (input) {
        if (input!.isEmpty || input.isWhitespace()) {
          return "Campo obrigatório";
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CardNumberFormatter(),
      ],
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Image.network(
        //     'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/800px-Mastercard-logo.svg.png',
        //     height: 30,
        //     width: 30,
        //   ),
        // ),
        suffixIcon: IconButton(
          onPressed: () => setState(() {}),
          icon: Icon(Icons.camera_alt, color: appStyle.iconColor),
        ),
        border: const OutlineInputBorder(),
        hintText: 'XXXX XXXX XXXX XXXX',
        labelText: 'Número do Cartão',
      ),
      maxLength: 19,
      onChanged: (value) {},
      style: appStyle.inputStyle,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simutax_mobile/extensions/string.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class CreditCardCVCField extends StatefulWidget {
  const CreditCardCVCField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _CreditCardCVCFieldState();
}

class _CreditCardCVCFieldState extends State<CreditCardCVCField> {
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
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'XXX',
        labelText: 'Código CVC',
      ),
      maxLength: 3,
      onChanged: (value) {},
      style: appStyle.inputStyle,
    );
  }
}

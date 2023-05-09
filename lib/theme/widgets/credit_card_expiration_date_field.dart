import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simutax_mobile/extensions/formatter.dart';
import 'package:simutax_mobile/extensions/string.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class CreditCardExpirationDateField extends StatefulWidget {
  const CreditCardExpirationDateField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _CreditCardExpirationDateFieldState();
}

class _CreditCardExpirationDateFieldState
    extends State<CreditCardExpirationDateField> {
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
        CardExpirationFormatter(),
      ],
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'XX/XX',
        labelText: 'Data de Expiração',
      ),
      maxLength: 5,
      onChanged: (value) {},
      style: appStyle.inputStyle,
    );
  }
}

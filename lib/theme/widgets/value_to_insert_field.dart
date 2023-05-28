import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class ValueToInsertField extends StatefulWidget {
  const ValueToInsertField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _ValueToInsertFieldState();
}

class _ValueToInsertFieldState extends State<ValueToInsertField> {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == '0,00') {
          return 'Campo obrigatório';
        }
        return null;
      },
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: appStyle.darkGrey, width: 3)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: appStyle.darkGrey, width: 3)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: appStyle.darkBlue, width: 3)),
        filled: false,
      ),
      style: appStyle.validValueInputStyle,
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(
          locale: 'pt_br',
          decimalDigits: 2,
          symbol: '',
        ),
      ],
      onChanged: (value) {
        widget.controller.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
      },
    );
  }
}

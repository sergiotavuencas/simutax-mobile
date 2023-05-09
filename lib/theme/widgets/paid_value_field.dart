import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simutax_front/extensions/string.dart';
import 'package:simutax_front/theme/app_style.dart';

class PaidValueField extends StatefulWidget {
  const PaidValueField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _PaidValueFieldState();
}

class _PaidValueFieldState extends State<PaidValueField> {
  static const locale = 'pt_br';
  String formatNumber(String s) =>
      NumberFormat.decimalPattern(locale).format(int.parse(s));
  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return TextFormField(
      controller: widget.controller,
      validator: (input) {
        if (input!.isEmpty || input.isWhitespace()) {
          return "Campo obrigatório";
        }
        if (input.hasSpace()) {
          return "Sem espaços em branco";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Valor pago",
        prefixText: currency,
      ),
      style: appStyle.inputStyle,
      onChanged: (value) {
        value = formatNumber(value.replaceAll(',', '.'));
        widget.controller.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
      },
    );
  }
}

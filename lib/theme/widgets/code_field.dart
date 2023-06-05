import 'package:flutter/material.dart';
import 'package:simutax_mobile/extensions/string.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class CodeField extends StatefulWidget {
  const CodeField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return TextFormField(
      controller: widget.controller,
      validator: (input) =>
          input!.isEmpty || input.isWhitespace() ? "Obrigatório" : null,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Código",
        helperText: "",
      ),
      style: appStyle.inputStyle,
    );
  }
}

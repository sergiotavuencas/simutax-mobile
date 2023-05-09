import 'package:flutter/material.dart';
import 'package:simutax_front/extensions/string.dart';
import 'package:simutax_front/theme/app_style.dart';

class EmailField extends StatefulWidget {
  const EmailField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return TextFormField(
      controller: widget.controller,
      validator: (input) => input!.isValidEmail() ? null : "Email inválido",
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Insira o seu endereço de email",
      ),
      style: appStyle.inputStyle,
    );
  }
}

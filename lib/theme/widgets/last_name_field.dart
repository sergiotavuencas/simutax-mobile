import 'package:flutter/material.dart';
import 'package:simutax_front/extensions/string.dart';
import 'package:simutax_front/theme/app_style.dart';

class LastNameField extends StatefulWidget {
  const LastNameField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _LastNameFieldState();
}

class _LastNameFieldState extends State<LastNameField> {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return TextFormField(
      controller: widget.controller,
      validator: (input) {
        if (input!.isEmpty || input.isWhitespace()) {
          return "Campo obrigatório";
        }
        if (input.hasNumber()) {
          return "Apenas letras";
        }
        if (input.hasSpace()) {
          return "Sem espaços em branco";
        }
        return null;
      },
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: "Sobrenome",
        hintText: "Insira o seu sobrenome",
      ),
      style: appStyle.inputStyle,
    );
  }
}

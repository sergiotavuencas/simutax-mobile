import 'package:flutter/material.dart';
import 'package:simutax_front/extensions/string.dart';
import 'package:simutax_front/theme/app_style.dart';

class FullNameField extends StatefulWidget {
  const FullNameField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _FullNameFieldState();
}

class _FullNameFieldState extends State<FullNameField> {
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
        return null;
      },
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: "Nome do Titular do Cartão",
        hintText: "Insira o seu nome",
      ),
      style: appStyle.inputStyle,
    );
  }
}

import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:simutax_mobile/extensions/string.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class CpfCnpjField extends StatefulWidget {
  const CpfCnpjField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _CpfCnpjFieldState();
}

class _CpfCnpjFieldState extends State<CpfCnpjField> {
  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return TextFormField(
      controller: widget.controller,
      validator: (input) {
        if (input!.isEmpty || input.isWhitespace()) {
          return "Campo obrigatório";
        }
        if (!CPFValidator.isValid(input) && !CNPJValidator.isValid(input)) {
          return "Valor inválido";
        }
        return null;
      },
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: "CPF/CNPJ",
        hintText: "Insira o seu CPF/CNPJ",
      ),
      style: appStyle.inputStyle,
    );
  }
}

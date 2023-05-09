import 'package:flutter/material.dart';
import 'package:simutax_front/extensions/string.dart';
import 'package:simutax_front/theme/app_style.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return TextFormField(
      controller: widget.controller,
      validator: (input) =>
          input!.hasLength(6, 18) ? null : "Mínimo 6, máximo 18 caracteres",
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: "Senha",
        helperText: "",
        suffixIcon: IconButton(
          onPressed: () => setState(() {
            obscurePassword = !obscurePassword;
          }),
          icon: Icon(!obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: appStyle.iconColor),
        ),
      ),
      style: appStyle.inputStyle,
    );
  }
}

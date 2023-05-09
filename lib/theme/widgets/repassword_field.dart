import 'package:flutter/material.dart';
import 'package:simutax_front/theme/app_style.dart';

class RepasswordField extends StatefulWidget {
  const RepasswordField(
      {super.key,
      required this.passwordController,
      required this.repasswordController});
  final TextEditingController passwordController;
  final TextEditingController repasswordController;

  @override
  State<StatefulWidget> createState() => _RepasswordFieldState();
}

class _RepasswordFieldState extends State<RepasswordField> {
  bool obscureRepassword = true;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return TextFormField(
      controller: widget.repasswordController,
      validator: (input) {
        if (input != widget.passwordController.text) {
          return "As senhas não coincidem";
        }
        return null;
      },
      obscureText: obscureRepassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: const InputDecoration(
        labelText: "Confirmar senha",
        helperText: "",
      ),
      style: appStyle.inputStyle,
    );
  }
}

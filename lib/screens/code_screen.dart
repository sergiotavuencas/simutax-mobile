import 'package:flutter/material.dart';
import 'package:simutax_mobile/screens/forgot_password_screen.dart';
import 'package:simutax_mobile/screens/reset_password_screen.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/widgets/code_field.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CodeScreenViewState();
}

class _CodeScreenViewState extends State<CodeScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final descriptionBox = SizedBox(
      child: Text("Insira o código enviado ao e-mail cadastrado.",
          style: appStyle.descriptionStyle),
    );

    final codeField = CodeField(controller: codeController);

    final redefineButton = ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const ResetPasswordScreen(),
              ),
            );
          });
        }
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Continuar",
              style: appStyle.buttonStyleBlue,
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 95, 95, 95)),
          )
        ],
      ),
    );

    final fields = SizedBox(
      width: appStyle.width / 1.1,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: descriptionBox,
          ),
          codeField,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Redefinir Senha'),
        leading: IconButton(
          icon: Icon(Icons.close, color: appStyle.darkGrey),
          onPressed: () => {
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const ForgotPasswordScreen(),
              ),
            )
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: appStyle.height / 1.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: appStyle.height / 20),
                      child: fields,
                    ),
                    SizedBox(
                      width: appStyle.width / 1.1,
                      child: redefineButton,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

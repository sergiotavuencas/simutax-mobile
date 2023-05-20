import 'package:flutter/material.dart';
import 'package:simutax_mobile/screens/reset_password_screen.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/widgets/email_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordScreenViewState();
}

class _ForgotPasswordScreenViewState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final descriptionBox = SizedBox(
      child: Text(
          "Insira o seu endereço de e-mail para que possamos enviar um link para redefinir sua senha.",
          style: appStyle.descriptionStyle),
    );

    final emailField = EmailField(controller: emailController);

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
          emailField,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Redefinir Senha'),
        leading: IconButton(
          icon: Icon(Icons.close, color: appStyle.darkGrey),
          onPressed: () => Navigator.of(context).pop(),
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

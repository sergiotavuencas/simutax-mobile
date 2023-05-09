import 'package:flutter/material.dart';
import 'package:simutax_front/routes.dart';
import 'package:simutax_front/theme/app_style.dart';

import '../theme/widgets/email_field.dart';
import '../theme/widgets/login_password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final appLogo = ClipRect(
      child: Image.asset(
        "lib/resources/simutax-mobile-logo.png",
        width: appStyle.width / 1.3,
        height: appStyle.height / 3.5,
        // fit: BoxFit.cover,
      ),
    );

    final emailField = EmailField(controller: emailController);
    final passwordField = LoginPasswordField(controller: passwordController);

    final accessButton = ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushNamed(AppRoutes.homeScreen);
          });
        }
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Text(
        "Acessar",
        style: appStyle.buttonStyleBlue,
      ),
    );

    final registerButton = ElevatedButton(
      onPressed: () async {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            Navigator.of(context).pushNamed(AppRoutes.registerScreen);
          },
        );
      },
      style: appStyle.createButtonTheme(appStyle.mediumGrey),
      child: Text(
        "Registrar-se",
        style: appStyle.buttonStyleGrey,
      ),
    );

    final forgotAnchor = MaterialButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.forgotPasswordScreen);
      },
      child: Text(
        "Esqueceu sua senha?",
        style: appStyle.buttonStyleGrey,
      ),
    );

    final fields = SizedBox(
      width: appStyle.width / 1.2,
      child: Column(
        children: <Widget>[
          emailField,
          passwordField,
          accessButton,
          registerButton,
          forgotAnchor
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 40),
                  child: widget,
                ))
            .toList(),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: appStyle.height / 30,
                        top: appStyle.height / 35),
                    child: appLogo,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: appStyle.height / 20),
                    child: fields,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

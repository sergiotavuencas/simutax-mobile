import 'dart:convert';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/theme/app_style.dart';
// import 'package:simutax_mobile/theme/utils.dart';

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
  late SharedPreferences prefs;
  late Future<bool> canAdvance;

  Future<bool> handleUserLogin() async {
    try {
      prefs = await SharedPreferences.getInstance();
      final api = Uri.parse("http://10.0.2.2:300/api/loginUser");
      http.Response response = await http.post(api, body: {
        "email": emailController.text,
        "password": passwordController.text,
      });
      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        String token = data["message"]["token"];
        prefs.setString('user_token', token);
        return true;
      } else if (response.statusCode == 400) {
        String message = data["message"] == "Senha invalida"
            ? "Dados inválidos"
            : data["message"];
        prefs.setString('user_login_error', message);
        return false;
      }
    } catch (error) {
      prefs.setString('user_login_error', error.toString());
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    // final utils = Utils(context);

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
        Navigator.of(context).pushNamed(AppRoutes.homeScreen);
        // if (formKey.currentState!.validate()) {
        //   canAdvance = handleUserLogin();

        //   if (await canAdvance) {
        //     utils.snack('Efetuando login! Aguarde...');
        //     Future.delayed(const Duration(seconds: 2), () {
        //       Navigator.of(context).pushNamed(AppRoutes.homeScreen);
        //     });
        //   } else {
        //     String? error = prefs.getString('user_login_error');
        //     utils.alert('ERRO: $error');
        //   }
        // }
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
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text("Toque de novo para sair")),
        child: Form(
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
      ),
    );
  }
}

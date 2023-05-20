import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'package:simutax_mobile/theme/widgets/cpf_cnpj_field.dart';
import 'package:simutax_mobile/theme/widgets/email_field.dart';
import 'package:simutax_mobile/theme/widgets/first_name_field.dart';
import 'package:simutax_mobile/theme/widgets/last_name_field.dart';
import 'package:simutax_mobile/theme/widgets/password_field.dart';
import 'package:simutax_mobile/theme/widgets/repassword_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cpfCnpjController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  bool agreeWithLGPD = false;
  late SharedPreferences prefs;
  late Future<bool> canAdvance;

  Future<bool> handleUserCreation() async {
      try {
        prefs = await SharedPreferences.getInstance();
        final api = Uri.parse("http://10.0.2.2:300/api/createUser");
        http.Response response = await http.post(api, body: {
          "firstname": firstNameController.text,
          "lastname": lastNameController.text,
          "identity": cpfCnpjController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "terms": 'true'
        });
        Map<String, dynamic> data = jsonDecode(response.body);

        if (response.statusCode == 201) {
          String token = data["message"]["token"];
          prefs.setString('user_token', token);
          return true;
        } else if (response.statusCode == 400) {
          String message = "Usuário já cadastrado";
          prefs.setString('user_registration_error', message);
          return false;
        }
      } catch (error) {
        prefs.setString('user_registration_error', error.toString());
      }

      return false;
    }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final descriptionBox = SizedBox(
      child: Text(
          "Preencha todos os campos para efetuar o registro e receber acesso ao aplicativo.",
          style: appStyle.descriptionStyle),
    );

    final firstNameField = FirstNameField(controller: firstNameController);
    final lastNameField = LastNameField(controller: lastNameController);
    final cpfCnpjField = CpfCnpjField(controller: cpfCnpjController);
    final emailField = EmailField(controller: emailController);
    final passwordField = PasswordField(controller: passwordController);
    final repasswordField = RepasswordField(
        passwordController: passwordController,
        repasswordController: repasswordController);

    final registerButton = ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate() && agreeWithLGPD) {
          canAdvance = handleUserCreation();

          if (await canAdvance) {
            utils.snack('Cadastro efetuado! Aguarde...');
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
          } else {
            String? error = prefs.getString('user_registration_error');
            utils.alert('ERRO: $error');
          }
        }
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Text(
        "Registrar-se",
        style: appStyle.buttonStyleBlue,
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
          firstNameField,
          lastNameField,
          cpfCnpjField,
          emailField,
          passwordField,
          repasswordField,
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 70),
                  child: widget,
                ))
            .toList(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
        leading: IconButton(
          icon: Icon(Icons.close, color: appStyle.darkGrey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
                    padding: EdgeInsets.only(top: appStyle.height / 40),
                    child: fields,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: appStyle.height / 40),
                    child: SizedBox(
                      width: appStyle.width / 1.2,
                      child: SizedBox(
                        width: appStyle.width / 1.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              child: Checkbox(
                                activeColor: appStyle.darkBlue,
                                checkColor: appStyle.yellow,
                                value: agreeWithLGPD,
                                onChanged: (value) {
                                  setState(() {
                                    agreeWithLGPD = value ?? false;
                                  });
                                },
                              ),
                            ),
                            const Text("Li e concordo com os termos da LGPD")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: appStyle.height / 20),
                    child: SizedBox(
                      width: appStyle.width / 1.1,
                      child: registerButton,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

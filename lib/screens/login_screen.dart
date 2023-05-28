import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/screens/loading_screen.dart';
import 'package:simutax_mobile/services/encrypt_data.dart';
import 'package:simutax_mobile/services/services.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';

import '../theme/widgets/email_field.dart';
import '../theme/widgets/login_password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late SharedPreferences _prefs;
  final String _tKey = EncryptData.encryptAES('user_token');
  final String _mKey = EncryptData.encryptAES('login_message');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final appLogo = ClipRect(
      child: Image.asset(
        "lib/resources/simutax-mobile-logo.png",
        width: appStyle.width / 1.3,
        height: appStyle.height / 3.5,
        // fit: BoxFit.cover,
      ),
    );

    final emailField = EmailField(controller: _emailController);
    final passwordField = LoginPasswordField(controller: _passwordController);

    final accessButton = ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          startAnimation();
          if (await _handleLogin()) {
            utils.snack('Efetuando login! Aguarde...');
            Future.delayed(const Duration(seconds: 4), () {
              endAnimation();
              Navigator.of(context).pushNamed(AppRoutes.homeScreen);
            });
          } else {
            endAnimation();
            // String? message = _prefs.getString(_mKey);
            // utils.alert('ERRO: $message');
          }
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

    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.white,
            body: DoubleBackToCloseApp(
              snackBar:
                  const SnackBar(content: Text("Toque de novo para sair")),
              child: Form(
                key: _formKey,
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
                            padding:
                                EdgeInsets.only(bottom: appStyle.height / 20),
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

  void startAnimation() async {
    setState(() {
      isLoading = true;
    });
  }

  void endAnimation() async {
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> _handleLogin() async {
    Map<String, dynamic> data = await Services().login(
        {'email': _emailController.text, 'password': _passwordController.text});

    if (data.containsKey('code')) {
      _prefs = await SharedPreferences.getInstance();

      if (data['code'] == 201) {
        _prefs.setString(_tKey, data['token']);
        return true;
      } else if (data['code'] == 400) {
        _prefs.setString(_mKey, data['message']);
        return false;
      }
    }
    return false;
  }
}

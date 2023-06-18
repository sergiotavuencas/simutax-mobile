import 'package:flutter/material.dart';
import 'package:simutax_mobile/screens/loading_screen.dart';
import 'package:simutax_mobile/screens/reset_password_screen.dart';
import 'package:simutax_mobile/services/user/user_services.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'package:simutax_mobile/theme/widgets/email_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordScreenViewState();
}

class _ForgotPasswordScreenViewState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final descriptionBox = SizedBox(
      child: Text(
          "Insira o seu endereço de e-mail para que possamos enviar um link para redefinir sua senha.",
          style: appStyle.descriptionStyle),
    );

    final emailField = EmailField(controller: _emailController);

    final redefineButton = ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _startAnimation();
          if (await _handleForgot()) {
            Future.delayed(const Duration(seconds: 2), () {
              _endAnimation();
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const ResetPasswordScreen(),
                ),
              );
            });
          } else {
            _endAnimation();
            utils.alert('Erro ao enviar o email.');
          }
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

    return isLoading
        ? const LoadingScreen()
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Redefinir Senha'),
                leading: IconButton(
                  icon: Icon(Icons.close, color: appStyle.darkGrey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              backgroundColor: Colors.white,
              body: Form(
                key: _formKey,
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
                              padding:
                                  EdgeInsets.only(top: appStyle.height / 20),
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
            ),
          );
  }

  void _startAnimation() async {
    setState(() {
      isLoading = true;
    });
  }

  void _endAnimation() async {
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> _handleForgot() async {
    bool canAdvance = false;
    Map<String, dynamic> data = await UserServices().forgot({
      'email': _emailController.text,
    });

    if (data.containsKey('code')) {
      data['code'] == 5 ? canAdvance = true : null;
    }

    return canAdvance;
  }
}

import 'package:flutter/material.dart';
import 'package:simutax_mobile/screens/loading_screen.dart';
import 'package:simutax_mobile/services/user/user_services.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'package:simutax_mobile/theme/widgets/code_field.dart';
import 'package:simutax_mobile/theme/widgets/password_field.dart';
import 'package:simutax_mobile/theme/widgets/repassword_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ResetPasswordScreenViewState();
}

class _ResetPasswordScreenViewState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final descriptionBox = SizedBox(
      child: Text("Insira sua nova senha.", style: appStyle.descriptionStyle),
    );

    final tokenField = CodeField(controller: _tokenController);
    final passwordField = PasswordField(controller: _passwordController);
    final repasswordField = RepasswordField(
        passwordController: _passwordController,
        repasswordController: _repasswordController);

    final fields = SizedBox(
      width: appStyle.width / 1.1,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: descriptionBox,
          ),
          tokenField,
          passwordField,
          repasswordField
        ],
      ),
    );

    final redefineButton = ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _startAnimation();
          if (await _handleValidate()) {
            Future.delayed(const Duration(seconds: 2), () {
              _endAnimation();
              Navigator.pop(context);
            });
          } else {
            _endAnimation();
            utils.alert('Código incorreto.');
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

    return isLoading
        ? const LoadingScreen()
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Redefinir Senha'),
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

  Future<bool> _handleValidate() async {
    bool canAdvance = false;
    Map<String, dynamic> data = await UserServices().validate({
      'token': _tokenController.text,
    });

    if (data.containsKey('code')) {
      if (data['code'] != null) {
        await _handleReset(data['code']) == true ? canAdvance = true : null;
      }
    }

    return canAdvance;
  }

  Future<bool> _handleReset(String code) async {
    bool canAdvance = false;
    Map<String, dynamic> data = await UserServices().reset({
      'token': code,
      'password': _passwordController.text,
    });

    if (data.containsKey('code')) {
      data['code'] == 10 ? canAdvance = true : null;
    }

    return canAdvance;
  }
}

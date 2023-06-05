import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simutax_mobile/screens/loading_screen.dart';
import 'package:simutax_mobile/services/encrypt_data.dart';
import 'package:simutax_mobile/services/user/user_services.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'package:simutax_mobile/theme/widgets/cpf_cnpj_field.dart';
import 'package:simutax_mobile/theme/widgets/email_field.dart';
import 'package:simutax_mobile/theme/widgets/first_name_field.dart';
import 'package:simutax_mobile/theme/widgets/last_name_field.dart';
import 'package:simutax_mobile/theme/widgets/password_field.dart';
import 'package:simutax_mobile/theme/widgets/repassword_field.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreen> {
  late SharedPreferences _prefs;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cpfCnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final String _tKey = EncryptData.encryptAES('user_token');
  final String _mKey = EncryptData.encryptAES('registration_message');
  bool _agreeWithLGPD = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final descriptionBox = SizedBox(
      child: Text(
          'Preencha todos os campos para efetuar o registro e receber acesso ao aplicativo.',
          style: appStyle.descriptionStyle),
    );

    final firstNameField = FirstNameField(controller: _firstNameController);
    final lastNameField = LastNameField(controller: _lastNameController);
    final cpfCnpjField = CpfCnpjField(controller: _cpfCnpjController);
    final emailField = EmailField(controller: _emailController);
    final passwordField = PasswordField(controller: _passwordController);
    final repasswordField = RepasswordField(
        passwordController: _passwordController,
        repasswordController: _repasswordController);

    final registerButton = ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate() && _agreeWithLGPD) {
          startAnimation();
          if (await _handleRegistration()) {
            utils.snack('Cadastro efetuado! Aguarde...');
            Future.delayed(const Duration(seconds: 4), () {
              endAnimation();
              Navigator.of(context).pop();
            });
          } else {
            endAnimation();
            utils.alert('Erro ao efetuar o registro.');
          }
        }
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Text(
        'Registrar-se',
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

    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Registrar'),
              leading: IconButton(
                icon: Icon(Icons.close, color: appStyle.darkGrey),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
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
                          padding:
                              EdgeInsets.only(bottom: appStyle.height / 40),
                          child: SizedBox(
                            width: appStyle.width / 1.2,
                            child: SizedBox(
                              width: appStyle.width / 1.2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    child: Checkbox(
                                      activeColor: appStyle.darkBlue,
                                      checkColor: appStyle.yellow,
                                      value: _agreeWithLGPD,
                                      onChanged: (value) {
                                        setState(() {
                                          _agreeWithLGPD = value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Li e concordo com os ',
                                          style: appStyle.descriptionStyle,
                                        ),
                                        TextSpan(
                                          text: 'termos da LGPD',
                                          style: appStyle.hyperlinkStyle,
                                          recognizer: TapGestureRecognizer()
                                            // ..onTap = () {
                                            //   launchUrl(Uri.parse(
                                            //       'https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm'));
                                            // },
                                            ..onTap = () async {
                                              final uri = Uri.parse(
                                                  'https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm');
                                              if (await canLaunchUrl(uri)) {
                                                await launchUrl(
                                                  uri,
                                                );
                                              }
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                  // const Text('Li e concordo com os termos da LGPD')
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

  Future<bool> _handleRegistration() async {
    bool canAdvance = false;
    _prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = await UserServices().register({
      'firstname': _firstNameController.text,
      'lastname': _lastNameController.text,
      'identity': _cpfCnpjController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'terms': 'true'
    });

    if (data.containsKey('code')) {
      if (data['code'] == 201) {
        _prefs.setString(_tKey, data['token']);
        canAdvance = true;
      } else if (data['code'] == 400) {
        _prefs.setString(_mKey, data['message']);
      }
    }

    return canAdvance;
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/screens/loading_screen.dart';
import 'package:simutax_mobile/services/encrypt_data.dart';
import 'package:simutax_mobile/services/user/user_services.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'package:simutax_mobile/theme/widgets/email_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileScreenViewState();
}

class _EditProfileScreenViewState extends State<EditProfileScreen> {
  late SharedPreferences _prefs;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final String _tKey = EncryptData.encryptAES('user_token');
  final String _nKey = EncryptData.encryptAES('user_name');
  String name = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    await _handleData();
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final profileClip = Material(
      borderRadius: BorderRadius.circular(80),
      elevation: 5,
      color: appStyle.darkBlue,
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.transparent,
        child: Text(
          name[0].toUpperCase(),
          style: appStyle.profileClipStyle,
        ),
      ),
    );

    final profileName = SizedBox(
      width: appStyle.width / 1.1,
      height: appStyle.height / 40,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              name.toUpperCase(),
              style: appStyle.profileNameStyle,
            ),
          )
        ],
      ),
    );

    final profileContainer = SizedBox(
      width: appStyle.width / 1.1,
      height: appStyle.height / 4.5,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: profileClip,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: profileName,
          ),
        ],
      ),
    );

    final emailField = EmailField(controller: _emailController);

    final fieldsContainer = SizedBox(
      width: appStyle.width / 1.1,
      child: Column(
        children: [emailField]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 70),
                  child: widget,
                ))
            .toList(),
      ),
    );

    final saveButton = SizedBox(
      width: appStyle.width / 1.1,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            startAnimation();
            if (await _handleEdit()) {
              utils.snack('E-mail alterado com sucesso!');
              Future.delayed(const Duration(seconds: 1), () {
                endAnimation();
                Navigator.of(context).pop();
              });
            } else {
              endAnimation();
              utils.alert('Não foi possível mudar o e-mail.');
            }
          }
        },
        style: appStyle.createButtonTheme(appStyle.darkBlue),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Salvar",
                style: appStyle.buttonStyleBlue,
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios, color: Colors.white),
            )
          ],
        ),
      ),
    );

    // final shutAccountAnchor = MaterialButton(
    //   splashColor: Colors.transparent,
    //   highlightColor: Colors.transparent,
    //   onPressed: () {
    //     Navigator.pushNamed(context, AppRoutes.shutProfileScreen);
    //   },
    //   child: Text(
    //     "Encerrar conta?",
    //     style: appStyle.buttonStyleGrey,
    //   ),
    // );

    return isLoading
        ? const LoadingScreen()
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Editar'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Color.fromARGB(255, 95, 95, 95)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: profileContainer,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: fieldsContainer,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: saveButton,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: shutAccountAnchor,
                            // ),
                          ],
                        ),
                      ],
                    )),
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

  Future<void> _handleData() async {
    _prefs = await SharedPreferences.getInstance();
    String? n = _prefs.getString(_nKey);

    if (n != null) {
      setState(() {
        name = n;
      });
    }
  }

  Future<bool> _handleEdit() async {
    bool canAdvance = false;
    _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString(_tKey);
    Map<String, dynamic> data = await UserServices().edit({
      'email': _emailController.text,
    }, {
      'Authorization': 'Bearer $token',
    });

    if (data.containsKey('code')) {
      if (data['code'] == 10) {
        canAdvance = true;
      }
    }

    return canAdvance;
  }
}

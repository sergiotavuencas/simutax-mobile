import 'package:flutter/material.dart';
import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/widgets/cpf_cnpj_field.dart';
import 'package:simutax_mobile/theme/widgets/email_field.dart';
import 'package:simutax_mobile/theme/widgets/first_name_field.dart';
import 'package:simutax_mobile/theme/widgets/last_name_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileScreenViewState();
}

class _EditProfileScreenViewState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cpfCnpjController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final profileClip = Material(
      borderRadius: BorderRadius.circular(80),
      elevation: 5,
      color: appStyle.darkBlue,
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.transparent,
        child: Text(
          "F",
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
              "Fulano de Tal",
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

    final firstNameField = FirstNameField(controller: firstNameController);
    final lastNameField = LastNameField(controller: lastNameController);
    final cpfCnpjField = CpfCnpjField(controller: cpfCnpjController);
    final emailField = EmailField(controller: emailController);

    final fieldsContainer = SizedBox(
      width: appStyle.width / 1.1,
      child: Column(
        children: [firstNameField, lastNameField, cpfCnpjField, emailField]
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
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushNamed(AppRoutes.pixPaymentScreen);
          });
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

    final shutAccountAnchor = MaterialButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.shutProfileScreen);
      },
      child: Text(
        "Encerrar conta?",
        style: appStyle.buttonStyleGrey,
      ),
    );

    return Scaffold(
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: shutAccountAnchor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

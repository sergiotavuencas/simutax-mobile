import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/widgets/brand_field.dart';
import 'package:simutax_mobile/theme/widgets/model_field.dart';
import 'package:simutax_mobile/theme/widgets/type_checkboxes.dart';

class ComparationScreen extends StatefulWidget {
  const ComparationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ComparationScreenViewState();
}

class _ComparationScreenViewState extends State<ComparationScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstBrandController = TextEditingController();
  final TextEditingController firstModelController = TextEditingController();
  final TextEditingController firstTypeController = TextEditingController();
  final TextEditingController secondBrandController = TextEditingController();
  final TextEditingController secondModelController = TextEditingController();
  final TextEditingController secondTypeController = TextEditingController();
  late SharedPreferences prefs;
  List<String> models = [];

  @override
  void initState() {
    super.initState();
    getModels();
  }

  void getModels() async {
    prefs = await SharedPreferences.getInstance();
    try {
      final String? token = prefs.getString('user_token');
      final api = Uri.parse("http://10.0.2.2:300/api/listAllModels");
      http.Response response = await http.post(api, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      models = (jsonDecode(response.body) as List<dynamic>).cast<String>();
    } catch (error) {
      prefs.setString('get_models_error', error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final descriptionBox = SizedBox(
      child: Text("Selecione as máquinas para comparar.",
          style: appStyle.descriptionStyle),
    );

    final firstBrandField = BrandField(models: models);
    final firstModelField = ModelField(controller: firstModelController);
    final firstTypeField = TypeCheckboxes(controller: firstTypeController);
    final secondBrandField = BrandField(models: models);
    final secondModelField = ModelField(controller: secondModelController);
    final secondTypeField = TypeCheckboxes(controller: secondTypeController);

    final firstDeviceContainer = SizedBox(
      width: appStyle.width / 1.2,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Máquina 1:", style: appStyle.descriptionStyle)),
          ),
          firstBrandField,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: appStyle.width / 2.6,
                child: firstModelField,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: appStyle.width / 2.6,
                  child: firstTypeField,
                ),
              ),
            ],
          )
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 70),
                  child: widget,
                ))
            .toList(),
      ),
    );

    final secondDeviceContainer = SizedBox(
      width: appStyle.width / 1.2,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Máquina 2:", style: appStyle.descriptionStyle)),
          ),
          secondBrandField,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: appStyle.width / 2.6,
                child: secondModelField,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: appStyle.width / 2.6,
                  child: secondTypeField,
                ),
              ),
            ],
          )
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 70),
                  child: widget,
                ))
            .toList(),
      ),
    );

    final compareButton = ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
        }
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Comparar",
              style: appStyle.buttonStyleBlue,
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          )
        ],
      ),
    );

    final dataFields = Column(
      children:
          <Widget>[descriptionBox, firstDeviceContainer, secondDeviceContainer]
              .map((widget) => Padding(
                    padding: EdgeInsets.only(bottom: appStyle.height / 20),
                    child: widget,
                  ))
              .toList(),
    );

    final fields = SizedBox(
      width: appStyle.width / 1.2,
      height: appStyle.height / 1.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          dataFields,
          compareButton,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 95, 95, 95)),
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: appStyle.height / 20),
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

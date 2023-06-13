import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simutax_mobile/screens/loading_screen.dart';
import 'package:simutax_mobile/services/device/device_services.dart';
import 'package:simutax_mobile/services/encrypt_data.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'package:simutax_mobile/theme/widgets/brand_field.dart';
import 'package:simutax_mobile/theme/widgets/paid_value_field.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SimulationScreenViewState();
}

class _SimulationScreenViewState extends State<SimulationScreen> {
  late SharedPreferences _prefs;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  /*
  final TextEditingController parcelValueToReceiveController =
      TextEditingController();
  final TextEditingController inCashValueToReceiveController =
      TextEditingController();
  final TextEditingController appliedTaxParcelController =
      TextEditingController();
  final TextEditingController appliedTaxInCashController =
      TextEditingController();
  */
  final TextEditingController creditController = TextEditingController();
  final TextEditingController debitController = TextEditingController();
  final String _tKey = EncryptData.encryptAES('user_token');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final descriptionBox = SizedBox(
      child: Text(
          "Informe o quanto você deseja receber e o quanto teria que cobrar para receber esse valor (R\$)",
          style: appStyle.descriptionStyle),
    );

    final brandField = BrandField(controller: _brandController);

    final priceField = Row(
      children: [
        SizedBox(
          width: appStyle.width / 2.3,
          child: PaidValueField(controller: _valueController),
        )
      ],
    );

    final inputFields = SizedBox(
      width: appStyle.width / 1.1,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: descriptionBox,
          ),
          brandField,
          priceField,
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 40),
                  child: widget,
                ))
            .toList(),
      ),
    );

    final creditContainer = SizedBox(
      width: appStyle.width / 2.3,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5), child: Text("Crédito")),
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text("(\$) Valor a receber:")),
          SizedBox(
            width: appStyle.width / 1.1,
            height: appStyle.height / 3,
            child: IgnorePointer(
              child: TextFormField(
                controller: creditController,
                style: appStyle.inputStyle,
              ),
            ),
          ),
        ],
      ),
    );

    final debitContainer = SizedBox(
      width: appStyle.width / 2.3,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5), child: Text("Débito")),
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text("(\$) Valor a receber:")),
          SizedBox(
            width: appStyle.width / 1.1,
            height: appStyle.height / 3,
            child: IgnorePointer(
              child: TextFormField(
                controller: debitController,
                style: appStyle.inputStyle,
              ),
            ),
          ),
        ],
      ),
    );

/*
    final parcelValueToReceiveContainer = SizedBox(
      width: appStyle.width / 2.3,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5), child: Text("Parcelado")),
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text("(\$) Valor a receber:")),
          SizedBox(
            width: appStyle.width / 1.1,
            height: appStyle.height / 3,
            child: IgnorePointer(
              child: TextFormField(
                controller: parcelValueToReceiveController,
                style: appStyle.inputStyle,
              ),
            ),
          ),
        ],
      ),
    );

    final inCashValueToReceiveContainer = SizedBox(
      width: appStyle.width / 2.3,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5), child: Text("À vista")),
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text("(\$) Valor a receber:")),
          SizedBox(
            width: appStyle.width / 1.1,
            height: appStyle.height / 3,
            child: IgnorePointer(
              child: TextFormField(
                controller: inCashValueToReceiveController,
                style: appStyle.inputStyle,
              ),
            ),
          ),
        ],
      ),
    );

    final appliedTaxParcelContainer = SizedBox(
      width: appStyle.width / 2.3,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text("(%) Taxa aplicada:")),
          SizedBox(
            width: appStyle.width / 1.1,
            height: appStyle.height / 3,
            child: IgnorePointer(
              child: TextFormField(
                controller: appliedTaxParcelController,
                style: appStyle.inputStyle,
              ),
            ),
          ),
        ],
      ),
    );

    final appliedTaxInCashContainer = SizedBox(
      width: appStyle.width / 2.3,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text("(%) Taxa aplicada:")),
          SizedBox(
            width: appStyle.width / 1.1,
            height: appStyle.height / 3,
            child: IgnorePointer(
              child: TextFormField(
                controller: appliedTaxInCashController,
                style: appStyle.inputStyle,
              ),
            ),
          ),
        ],
      ),
    );
*/

    final dataFields = SizedBox(
      width: appStyle.width / 1.1,
      child: Stack(
        children: [
          /*
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                parcelValueToReceiveContainer,
                inCashValueToReceiveContainer,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appliedTaxParcelContainer,
                  appliedTaxInCashContainer
                ],
              ),
            ),
          ),
          */
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                creditContainer,
                debitContainer,
              ],
            ),
          ),
        ],
      ),
    );

    final simulateButton = ElevatedButton(
      onPressed: () async {
        if (_brandController.text != 'Selecione uma marca' &&
            _brandController.text.isNotEmpty) {
          if (_formKey.currentState!.validate()) {
            utils.snack('Simulando! Aguarde...');
            startAnimation();
            if (await _handleSimulation()) {
              Future.delayed(const Duration(seconds: 1), () {
                _brandController.text = '';
                endAnimation();
              });
            } else {
              endAnimation();
              utils.snack('Ocorreu um erro...');
            }
          }
        } else {
          utils.snack('Selecione uma marca');
        }
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Simular",
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

    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Simular'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 95, 95, 95)),
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
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: appStyle.height / 40),
                          child: inputFields,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: dataFields,
                        ),
                        SizedBox(
                          width: appStyle.width / 1.1,
                          child: simulateButton,
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

  double _convert() {
    int valueLength = _valueController.text.length;
    String convert = _valueController.text;

    if (valueLength >= 8) {
      convert = convert.replaceAll(',', '.');
      convert = convert.replaceAll('.', '');
      return double.parse(convert);
    } else {
      return double.parse(convert.replaceAll(',', '.'));
    }
  }

  Future<bool> _handleSimulation() async {
    bool canAdvance = false;
    _prefs = await SharedPreferences.getInstance();
    String? t = _prefs.getString(_tKey);
    Map<String, dynamic> data = await DeviceServices().simulate(
        {'brand': _brandController.text, 'value': '${_convert()}'},
        {'Authorization': 'Bearer $t'});

    if (data.containsKey('debit') && data.containsKey('credit')) {
      setState(() {
        debitController.text = 'R\$ ${data['debit']}';
        creditController.text = 'R\$ ${data['credit']}';
      });
      canAdvance = true;
    }

    return canAdvance;
  }
}

import 'package:flutter/material.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/widgets/brand_field.dart';
import 'package:simutax_mobile/theme/widgets/paid_value_field.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SimulationScreenViewState();
}

class _SimulationScreenViewState extends State<SimulationScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController parcelValueToReceiveController =
      TextEditingController();
  final TextEditingController inCashValueToReceiveController =
      TextEditingController();
  final TextEditingController appliedTaxParcelController =
      TextEditingController();
  final TextEditingController appliedTaxInCashController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    parcelValueToReceiveController.text = "R\$ 50";
    inCashValueToReceiveController.text = "R\$ 100";
    appliedTaxParcelController.text = "1.99 %";
    appliedTaxInCashController.text = "0.99 %";

    final descriptionBox = SizedBox(
      child: Text(
          "Informe o quanto você deseja receber e o quanto teria que cobrar para receber esse valor (R\$)",
          style: appStyle.descriptionStyle),
    );

    final brandField = BrandField(controller: brandController);

    final priceField = Row(
      children: [
        SizedBox(
          width: appStyle.width / 2.3,
          child: PaidValueField(controller: priceController),
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

    final dataFields = SizedBox(
      width: appStyle.width / 1.1,
      child: Stack(
        children: [
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
        ],
      ),
    );

    final simulateButton = ElevatedButton(
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

    return Scaffold(
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
        key: formKey,
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
}

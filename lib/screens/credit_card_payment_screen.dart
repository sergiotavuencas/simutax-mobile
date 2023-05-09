import 'package:flutter/material.dart';
import 'package:simutax_front/theme/app_style.dart';
import 'package:simutax_front/theme/widgets/cpf_cnpj_field.dart';
import 'package:simutax_front/theme/widgets/credit_card_cvc_field.dart';
import 'package:simutax_front/theme/widgets/credit_card_expiration_date_field.dart';
import 'package:simutax_front/theme/widgets/credit_card_field.dart';
import 'package:simutax_front/theme/widgets/full_name_field.dart';

class CreditCardPaymentScreen extends StatefulWidget {
  const CreditCardPaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreditCardPaymentScreenViewState();
}

class _CreditCardPaymentScreenViewState extends State<CreditCardPaymentScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController creditCardController = TextEditingController();
  final TextEditingController creditCardExpirationDateController =
      TextEditingController();
  final TextEditingController creditCardCVCController = TextEditingController();
  bool useAccountBalance = false;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final descriptionBox = SizedBox(
      width: appStyle.width / 1.1,
      child: Text(
          "Preencha os seguintes campos para continuar com o pagamento.",
          style: appStyle.descriptionStyle),
    );

    final fullNameField = FullNameField(controller: fullNameController);
    final cpfField = CpfCnpjField(controller: cpfController);
    final creditCardField = CreditCardField(controller: creditCardController);
    final creditCardExpirationDateField = CreditCardExpirationDateField(
        controller: creditCardExpirationDateController);
    final creditCardCVCField =
        CreditCardCVCField(controller: creditCardCVCController);

    final expirationAndCVCField = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: appStyle.width / 2,
          child: creditCardExpirationDateField,
        ),
        SizedBox(
          width: appStyle.width / 2.9,
          child: creditCardCVCField,
        ),
      ],
    );

    final switchContainer = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: appStyle.width / 2,
          child: Text("Utilizar saldo da conta",
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        SizedBox(
          width: appStyle.width / 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: Switch(
              value: useAccountBalance,
              activeColor: const Color.fromARGB(255, 108, 146, 244),
              onChanged: (bool value) {
                setState(() {
                  useAccountBalance = value;
                });
              },
            ),
          ),
        ),
      ],
    );

    final continueButton = ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          Future.delayed(const Duration(seconds: 1), () {
            // Navigator.of(context).pushNamed(AppRoutes.rechargeScreen);
          });
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
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          )
        ],
      ),
    );

    final fields = Column(
      children: <Widget>[
        fullNameField,
        cpfField,
        creditCardField,
        expirationAndCVCField,
        switchContainer,
      ]
          .map((widget) => Padding(
                padding: EdgeInsets.only(bottom: appStyle.height / 70),
                child: widget,
              ))
          .toList(),
    );

    final content = SizedBox(
      width: appStyle.width / 1.1,
      height: appStyle.height / 1.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          fields,
          continueButton,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartão de Crédito'),
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
                    padding: const EdgeInsets.only(top: 40),
                    child: descriptionBox,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: appStyle.height / 40),
                    child: content,
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

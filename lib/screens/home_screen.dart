import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/screens/profile_screen.dart';
import 'package:simutax_mobile/services/encrypt_data.dart';
import 'package:simutax_mobile/services/user/user_services.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  final String _tKey = EncryptData.encryptAES('user_token');
  final String _nKey = EncryptData.encryptAES('user_name');
  final String _bKey = EncryptData.encryptAES('user_balance');
  String userBalance = '0,00';
  bool isBigger = false;

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    await _handleBalance();
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final rechargeButton = ElevatedButton(
      onPressed: () async {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushNamed(AppRoutes.paymentMethodScreen);
        });
      },
      style: appStyle.createButtonTheme(appStyle.mediumGrey),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              '\$ Adicionar Saldo',
              style: appStyle.buttonStyleGrey,
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

    final rechargeContainer = SizedBox(
      width: appStyle.width / 1.1,
      child: rechargeButton,
    );

    final balanceContainer = SizedBox(
      width: appStyle.width / 1.1,
      child: Container(
        decoration: BoxDecoration(
          color: appStyle.mediumGrey,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14, top: 10),
                  child: Text('Saldo disponível', style: appStyle.labelStyle),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: appStyle.width / 1.15,
                height: 40.0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text('R\$ $userBalance',
                        style: appStyle.descriptionStyle),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final compareIcon = ClipRect(
      child: Image.asset(
        'lib/resources/icone-comparacao.png',
        width: appStyle.width / 4,
        height: appStyle.height / 4,
        fit: BoxFit.scaleDown,
      ),
    );

    final compareContainer = MaterialButton(
      onPressed: () {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushNamed(AppRoutes.comparationScreen);
        });
      },
      child: SizedBox(
        width: appStyle.width / 2.4,
        child: Container(
          decoration: BoxDecoration(
            color: appStyle.mediumGrey,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: appStyle.height / 6,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: compareIcon,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text('COMPARAR', style: appStyle.labelStyle),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final simulateIcon = ClipRect(
      child: Image.asset(
        'lib/resources/icone-simulacao.png',
        width: appStyle.width / 3,
        height: appStyle.height / 3,
        fit: BoxFit.scaleDown,
      ),
    );

    final simulateContainer = MaterialButton(
      onPressed: () {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushNamed(AppRoutes.simulationScreen);
        });
      },
      child: SizedBox(
        width: appStyle.width / 2.4,
        child: Container(
          decoration: BoxDecoration(
            color: appStyle.mediumGrey,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: appStyle.height / 6,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: simulateIcon,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text('SIMULAR', style: appStyle.labelStyle),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final actionsContainer = Row(
      children: [compareContainer, simulateContainer],
    );

    final historyContainer = SizedBox(
      width: appStyle.width / 1.075,
      height: appStyle.height / 3.1,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRect(
              child: Image.asset(
                'lib/resources/history-example.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: appStyle.width / 1.3,
                  height: appStyle.height / 18,
                  decoration: BoxDecoration(
                    color: appStyle.mediumGrey,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Em breve seus registros apareceram aqui.',
                        style: appStyle.futureHistoryStyle),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );

    /*
    SizedBox(
      width: appStyle.width / 1.1,
      height: appStyle.height / 3.1,
      child: Container(
        decoration: BoxDecoration(
          color: appStyle.mediumGrey,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: ,
      ),
    );*/

    final fields = SizedBox(
      height: appStyle.height / 1.35,
      child: Column(
        children: <Widget>[
          rechargeContainer,
          balanceContainer,
          actionsContainer,
          historyContainer
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: appStyle.height / 60),
                  child: widget,
                ))
            .toList(),
      ),
    );

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ProfileScreen(),
                    ),
                  );
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Icon(Icons.account_circle,
                      size: 40, color: appStyle.darkBlue),
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: () async {
              await _handleBalance();
              if (isBigger) {
                // ignore: use_build_context_synchronously
                Utils(context)
                    .snack('Recebemos seu pagamento, saldo atualizado!');
                isBigger = false;
              } else {
                // ignore: use_build_context_synchronously
                Utils(context).snack('Saldo atualizado!');
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: appStyle.height / 1.25,
                width: appStyle.width,
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _handleBalance() async {
    _prefs = await SharedPreferences.getInstance();
    String? t = _prefs.getString(_tKey);
    String? b = _prefs.getString(_bKey);
    Map<String, dynamic> data =
        await UserServices().balance({'Authorization': 'Bearer $t'});

    if (data.containsKey('balance') && data.containsKey('name')) {
      if (b != null) {
        if (int.parse(b) < data['balance']) {
          setState(() {
            isBigger = true;
          });
        }
      }

      _prefs.setString(_nKey, data['name']);
      _prefs.setString(_bKey, data['balance'].toString());
      setState(() {
        userBalance = data['balance'].toString();
      });
    }
  }
}

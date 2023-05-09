import 'package:flutter/material.dart';
import 'package:simutax_mobile/routes.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreen> {
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
              "\$ Adicionar Saldo",
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
                  child: Text("Saldo disponível",
                      style: appStyle.descriptionStyle),
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
                    child: Text("R\$ 50,00", style: appStyle.descriptionStyle),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child:
                            Text("COMPARAR", style: appStyle.descriptionStyle),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child:
                            Text("SIMULAR", style: appStyle.descriptionStyle),
                      ),
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
      width: appStyle.width / 1.1,
      height: appStyle.height / 3.1,
      child: Container(
        decoration: BoxDecoration(
          color: appStyle.mediumGrey,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
                  padding: EdgeInsets.only(top: appStyle.height / 40),
                  child: fields,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

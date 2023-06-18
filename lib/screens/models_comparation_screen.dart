import 'package:flutter/material.dart';
import 'package:simutax_mobile/screens/comparation_screen.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class ModelsComparationScreen extends StatefulWidget {
  const ModelsComparationScreen(
      {super.key, required this.firstModel, required this.secondModel});
  final Map<String, dynamic> firstModel;
  final Map<String, dynamic> secondModel;

  @override
  State<StatefulWidget> createState() => _ModelsComparationScreenViewState();
}

class _ModelsComparationScreenViewState extends State<ModelsComparationScreen> {
  Map<String, dynamic> labels = {
    'brand': 'Marca:',
    'model': 'Modelo:',
    'battery': 'Bateria:',
    'connectivity': 'Conectividade:',
    'warrantly': 'Garantia:',
    'technology': 'Tecnologia:',
    'screen': 'Tela:',
  };

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final descriptionBox = SizedBox(
      child: Text("Comparação entre as máquinas selecionadas.",
          style: appStyle.descriptionStyle),
    );

    final firstModelTable = SizedBox(
      width: appStyle.width / 1.1,
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text('Máquina 1', style: appStyle.descriptionStyle)),
        _buildTable(widget.firstModel, appStyle),
      ]),
    );

    final secondModelTable = SizedBox(
      width: appStyle.width / 1.1,
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text('Máquina 2', style: appStyle.descriptionStyle)),
        _buildTable(widget.secondModel, appStyle),
      ]),
    );

    final content = Column(
      children: [descriptionBox, firstModelTable, secondModelTable]
          .map((widget) => Padding(
                padding: EdgeInsets.only(bottom: appStyle.height / 30),
                child: widget,
              ))
          .toList(),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comparação'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 95, 95, 95)),
            onPressed: () => Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ComparationScreen()),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
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

  Widget _buildTable(Map<String, dynamic> data, AppStyle appStyle) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: data.entries.map((element) {
        String label = labels[element.key];
        String value = element.value;

        return TableRow(
          children: <Widget>[
            Container(
                height: label == 'Tecnologia:'
                    ? appStyle.height / 10
                    : appStyle.height / 26,
                width: appStyle.width / 3,
                color: appStyle.darkBlue,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(label, style: appStyle.tableLabelStyle),
                  ),
                )),
            Container(
              height: label == 'Tecnologia:'
                  ? appStyle.height / 10
                  : appStyle.height / 26,
              width: appStyle.width / 2,
              color: appStyle.lightGrey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(value, style: appStyle.tableValueStyle),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

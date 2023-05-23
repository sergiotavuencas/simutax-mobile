// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class DeviceFields extends StatefulWidget {
  const DeviceFields(
      {super.key,
      required this.brandController,
      required this.modelController,
      required this.typeController});
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController typeController;

  @override
  State<StatefulWidget> createState() => _DeviceFieldsState();
}

class _DeviceFieldsState extends State<DeviceFields> {
  List<String> brands = [
    'Selecione uma marca',
    'Cielo',
    'PagSeguro',
    'Mercado Pago'
  ];
  Map<String, dynamic> modelsMap = {
    'Cielo': ['Cielo Lio', 'Cielo Flash', 'Cielo Zip'],
    'PagSeguro': ['Point Pro 2', 'Point Mini NFC 1', 'Point Smart'],
    'Mercado Pago': ['Moderninha Pro', 'Minizinha NFC', 'Moderninha Smart 2'],
  };
  List<String> models = [];
  List<String> buttonText = ['Venda', 'Aluguel'];
  String selectedBrand = 'Selecione uma marca';
  String selectedModel = '';
  int? selectedValueIndex;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    final brandDropDown = Container(
      width: appStyle.width / 1.1,
      height: appStyle.height / 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appStyle.lightGrey,
        border: Border.all(color: appStyle.mediumGrey, width: 2),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                items: brands
                    .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: appStyle.inputStyle)))
                    .toList(),
                onChanged: (value) => onSelectedBrand(value),
                value: selectedBrand,
              ),
            ),
          ),
        ],
      ),
    );

    final modelDropDown = Container(
      width: appStyle.width / 1.1,
      height: appStyle.height / 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appStyle.lightGrey,
        border: Border.all(color: appStyle.mediumGrey, width: 2),
      ),
      child: selectedBrand == 'Selecione uma marca'
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  items: models
                      .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: appStyle.inputStyle)))
                      .toList(),
                  onChanged: (value) => onSelectedModel(value),
                  value: selectedModel,
                ),
              ),
            ),
    );

    final typeSelect = Column(
      children: [
        ...List.generate(
          buttonText.length,
          (index) => button(
            index: index,
            text: buttonText[index],
          ),
        )
      ]
          .map((widget) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: widget,
              ))
          .toList(),
    );

    return SizedBox(
      width: appStyle.width / 1.2,
      child: Column(
        children: <Widget>[
          brandDropDown,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: appStyle.width / 1.8,
                child: modelDropDown,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: appStyle.width / 4.4,
                  child: typeSelect,
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
  }

  void onSelectedBrand(value) async {
    setState(() {
      selectedModel = 'Selecione um modelo';
      selectedBrand = value;
      widget.brandController.text = selectedBrand;
      models = ['Selecione um modelo'];
    });

    models = List.from(models)..addAll(modelsMap[selectedBrand]);
  }

  void onSelectedModel(value) {
    setState(() {
      selectedModel = value;
      widget.modelController.text = selectedModel;
    });
  }

  Widget button({required int index, required String text}) => InkWell(
        onTap: () {
          setState(() {
            selectedValueIndex = index;
            widget.typeController.text =
                selectedValueIndex == 0 ? 'Venda' : 'Aluguel';
          });
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: index == selectedValueIndex
                      ? const Color.fromARGB(255, 81, 98, 250)
                      : const Color.fromARGB(255, 232, 232, 232),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                      color: const Color.fromARGB(255, 232, 232, 232))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
}

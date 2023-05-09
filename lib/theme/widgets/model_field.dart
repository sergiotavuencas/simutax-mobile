import 'package:flutter/material.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class ModelField extends StatefulWidget {
  const ModelField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _ModelFieldState();
}

class _ModelFieldState extends State<ModelField> {
  List<String> registeredModels = ['001', '002', '003', '004', '005'];
  String selectedModel = '001';

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return Container(
      width: appStyle.width / 1.2,
      height: appStyle.height / 16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appStyle.lightGrey,
          border: Border.all(color: appStyle.mediumGrey, width: 2)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_sharp),
            items: registeredModels
                .map((String item) => DropdownMenuItem<String>(
                    value: item, child: Text(item, style: appStyle.inputStyle)))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedModel = value!;
              });
            },
            value: selectedModel,
          ),
        ),
      ),
    );
  }
}

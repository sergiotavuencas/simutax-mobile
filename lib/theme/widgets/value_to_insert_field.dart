import 'package:flutter/material.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class ValueToInsertField extends StatefulWidget {
  const ValueToInsertField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _ValueToInsertFieldState();
}

class _ValueToInsertFieldState extends State<ValueToInsertField> {
  List<String> allowedValues = ['', '10', '20', '30', '40', '50'];
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);

    return Container(
      width: appStyle.width / 1.1,
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
            items: allowedValues
                .map((String item) => DropdownMenuItem<String>(
                    value: item, child: Text(item, style: appStyle.inputStyle)))
                .toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  selectedValue = value;
                  widget.controller.text = selectedValue;
                }
              });
            },
            value: selectedValue,
          ),
        ),
      ),
    );
  }

  void onSelectedValue(value) async {
    setState(() {
      selectedValue = value;
      widget.controller.text = selectedValue;
    });
  }
}

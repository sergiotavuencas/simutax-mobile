// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class BrandField extends StatefulWidget {
  const BrandField({super.key, required this.controller});
  final TextEditingController controller;
  // BrandField({super.key, required this.models});
  // List<String> models;

  @override
  State<StatefulWidget> createState() => _BrandFieldState();
}

class _BrandFieldState extends State<BrandField> {
  List<String> brands = ['Cielo', 'PagSeguro', 'Mercado Pago'];
  String selectedBrand = 'Cielo';

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
            items: brands
                .map((String item) => DropdownMenuItem<String>(
                    value: item, child: Text(item, style: appStyle.inputStyle)))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedBrand = value!;
                widget.controller.text = selectedBrand;
              });
            },
            value: selectedBrand,
          ),
        ),
      ),
    );
  }
}

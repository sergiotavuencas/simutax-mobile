import 'package:flutter/material.dart';

class TypeCheckboxes extends StatefulWidget {
  const TypeCheckboxes({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _TypeCheckboxesState();
}

class _TypeCheckboxesState extends State<TypeCheckboxes> {
  int? _selectedValueIndex;
  List<String> buttonText = ["Venda", "Aluguel"];

  @override
  Widget build(BuildContext context) {
    return Column(
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
  }

  Widget button({required int index, required String text}) => InkWell(
        // splashColor: Colors.cyanAccent,
        onTap: () {
          setState(() {
            _selectedValueIndex = index;
          });
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: index == _selectedValueIndex
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

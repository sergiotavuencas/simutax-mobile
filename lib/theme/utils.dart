import 'package:flutter/material.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class Utils {
  late final BuildContext context;
  late final appStyle = AppStyle(context);

  Utils(this.context);

  void snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future alert(String message) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            child: Text(message, style: const TextStyle(color: Colors.black)),
          ),
        ),
      );
}

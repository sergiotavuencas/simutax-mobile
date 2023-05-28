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
            // width: appStyle.width / 1.1,
            height: appStyle.height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                  size: appStyle.height / 7,
                ),
                Text(message, style: const TextStyle(color: Colors.black))
              ],
            ),
          ),
        ),
      );
}

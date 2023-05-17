import 'package:flutter/material.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class Utils {
  Utils({required this.context});
  BuildContext context;
  late final appStyle = AppStyle(context);

  void snack(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }

  // Future loadingAnimation(AnimationController controller) => showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         content: SizedBox(
  //           height: 50,
  //           width: 20,
  //           child: Stack(
  //             children: [
  //               const Align(
  //                 alignment: Alignment.topCenter,
  //                 child: Padding(
  //                     padding: EdgeInsets.only(bottom: 10),
  //                     child: Text("Aguarde...")),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: SizedBox(
  //                   height: 20,
  //                   width: 20,
  //                   child: CircularProgressIndicator(
  //                     value: controller.value,
  //                     color: appStyle.yellow,
  //                     backgroundColor: appStyle.darkBlue,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     );

  Future alert(String message) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            child: Text(message, style: const TextStyle(color: Colors.black)),
          ),
        ),
      );
}

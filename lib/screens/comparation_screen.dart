import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simutax_mobile/screens/models_comparation_screen.dart';
import 'package:simutax_mobile/screens/loading_screen.dart';
import 'package:simutax_mobile/services/device/device_services.dart';
import 'package:simutax_mobile/services/encrypt_data.dart';
import 'package:simutax_mobile/services/user/user_services.dart';
import 'package:simutax_mobile/theme/app_style.dart';
import 'package:simutax_mobile/theme/utils.dart';
import 'package:simutax_mobile/theme/widgets/device_fields.dart';

class ComparationScreen extends StatefulWidget {
  const ComparationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ComparationScreenViewState();
}

class _ComparationScreenViewState extends State<ComparationScreen> {
  late SharedPreferences _prefs;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstBrandController = TextEditingController();
  final TextEditingController _firstModelController = TextEditingController();
  final TextEditingController _firstTypeController = TextEditingController();
  final TextEditingController _secondBrandController = TextEditingController();
  final TextEditingController _secondModelController = TextEditingController();
  final TextEditingController _secondTypeController = TextEditingController();
  final String _tKey = EncryptData.encryptAES('user_token');
  final String _mKey = EncryptData.encryptAES('comparation_message');
  late Map<String, dynamic> _firstModel;
  late Map<String, dynamic> _secondModel;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appStyle = AppStyle(context);
    final utils = Utils(context);

    final descriptionBox = SizedBox(
      child: Text("Selecione as máquinas para comparar.",
          style: appStyle.descriptionStyle),
    );

    final firstDeviceContainer = Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 15),
              child: Text("Máquina 1:", style: appStyle.descriptionStyle)),
        ),
        DeviceFields(
            brandController: _firstBrandController,
            modelController: _firstModelController,
            typeController: _firstTypeController)
      ],
    );

    final secondDeviceContainer = Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 15),
              child: Text("Máquina 2:", style: appStyle.descriptionStyle)),
        ),
        DeviceFields(
            brandController: _secondBrandController,
            modelController: _secondModelController,
            typeController: _secondTypeController)
      ],
    );

    final compareButton = ElevatedButton(
      onPressed: () async {
        if (await _handleDevices()) {
          if ((_firstModel.isNotEmpty && _secondModel.isNotEmpty) &&
              (_firstModel != _secondModel)) {
            utils.snack('Saldo atualizado!');
            startAnimation();
            Future.delayed(const Duration(seconds: 1), () {
              endAnimation();
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => ModelsComparationScreen(
                        firstModel: _firstModel, secondModel: _secondModel)),
              );
            });
          } else {
            endAnimation();
            String message = '';

            if (_firstModel.isEmpty && _secondModel.isEmpty) {
              message = 'Selecione as máquinas para comparar';
            } else if (_firstModel.isEmpty || _secondModel.isEmpty) {
              message = _firstModel.isEmpty
                  ? 'Selecione a máquina 1'
                  : 'Selecione a máquina 2';
            } else if (_firstModel == _secondModel) {
              message = 'Selecione máquinas diferentes para comparar';
            }
            utils.alert(message);
          }
        } else {
          utils.alert('Erro ao atualizar os dados.');
        }
      },
      style: appStyle.createButtonTheme(appStyle.darkBlue),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Comparar",
              style: appStyle.buttonStyleBlue,
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          )
        ],
      ),
    );

    final dataFields = Column(
      children:
          <Widget>[descriptionBox, firstDeviceContainer, secondDeviceContainer]
              .map((widget) => Padding(
                    padding: EdgeInsets.only(bottom: appStyle.height / 20),
                    child: widget,
                  ))
              .toList(),
    );

    final fields = SizedBox(
      width: appStyle.width / 1.2,
      height: appStyle.height / 1.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          dataFields,
          compareButton,
        ],
      ),
    );

    return isLoading
        ? const LoadingScreen()
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Comparar'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Color.fromARGB(255, 95, 95, 95)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              backgroundColor: Colors.white,
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: appStyle.height / 20),
                            child: fields,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void startAnimation() async {
    setState(() {
      isLoading = true;
    });
  }

  void endAnimation() async {
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> _handleDevices() async {
    bool canAdvance = false;
    _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString(_tKey);
    List<Map<String, dynamic>> data = await DeviceServices().devices({
      'Authorization': 'Bearer $token',
    });
    _firstModel = {};
    _secondModel = {};

    if (data[0].containsKey('code')) {
      if (data[0]['code'] == 201) {
        for (var element in data) {
          if (element.containsKey('brand') && element.containsKey('model')) {
            if (element['brand'] == _firstBrandController.text &&
                element['model'] == _firstModelController.text) {
              _firstModel = element;
            }
            if (element['brand'] == _secondBrandController.text &&
                element['model'] == _secondModelController.text) {
              _secondModel = element;
            }
          }
        }

        if (await _updateBalanceAndCoin(token!)) {
          canAdvance = true;
        }
      } else if (data[0]['code'] == 400) {
        _prefs.setString(_mKey, data[1]['message']);
      }
    }

    return canAdvance;
  }

  Future<bool> _updateBalanceAndCoin(String token) async {
    bool updated = false;
    Map<String, dynamic> coinData = await UserServices().updateCoin({
      'Authorization': 'Bearer $token',
    });

    if (coinData.containsKey('success')) {
      if (coinData['success']) {
        updated = true;
      } else {
        Map<String, dynamic> balanceData = await UserServices().updateBalance({
          'Authorization': 'Bearer $token',
        });

        if (balanceData.containsKey('success')) {
          if (balanceData['success']) {
            updated = true;
          }
        }
      }
    }

    return updated;
  }
}

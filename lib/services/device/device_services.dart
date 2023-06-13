import 'dart:convert';

import 'package:http/http.dart' as http;

class DeviceServices {
  final String _address = 'http://164.152.62.200:3000/api';
  late List<Map<String, dynamic>> _deviceData;

  Future<List<Map<String, dynamic>>> devices(
      Map<String, String> headers) async {
    var uri = Uri.parse('$_address/listAllModels');
    _deviceData = [];

    try {
      http.Response response = await http.get(uri, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _deviceData.add({'code': response.statusCode});
        jsonResponse['code']?.forEach((element) {
          Map<String, dynamic> mappedElement = {
            'brand': element['marca']['brand'],
            'model': element['name'],
            'battery': element['battery'],
            'connectivity': element['connectivity'],
            'warrantly': element['warrantly'],
            'technology': element['technology'],
            'screen': element['screen'],
          };
          _deviceData.add(mappedElement);
        });
      } else if (response.statusCode == 400) {
        _deviceData.add({'status_code': response.statusCode});
        _deviceData.add({'code': jsonResponse['code']});
      }
    } catch (error) {
      _deviceData.add({'error': error});
    }

    return _deviceData;
  }

  Future<Map<String, dynamic>> simulate(
      Map<String, dynamic> body, Map<String, String> headers) async {
    var uri = Uri.parse('$_address/simulate');
    // ignore: no_leading_underscores_for_local_identifiers
    Map<String, dynamic> _simulationData = {};

    try {
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _simulationData.addAll({
          'debit': jsonResponse['sucess']['debit'],
          'credit': jsonResponse['sucess']['credit'],
          'info': jsonResponse['sucess']['info'],
        });
      }
    } catch (error) {
      _simulationData.addAll({'error': error});
    }

    return _simulationData;
  }
}

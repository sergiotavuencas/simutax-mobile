import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Services {
  final String _address = 'http://10.0.2.2:300/api';
  late Map<String, dynamic> _userData;
  late List<Map<String, dynamic>> _deviceData;

  Future<Map<String, dynamic>> register(Map<String, dynamic> body) async {
    var uri = Uri.parse('$_address/createUser');
    _userData = {};

    try {
      http.Response response = await http.post(uri, body: body);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({
          'token': jsonResponse['message']['token'],
          'code': response.statusCode
        });
      } else if (response.statusCode == 400) {
        _userData.addAll(
            {'message': jsonResponse['message'], 'code': response.statusCode});
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    var uri = Uri.parse('$_address/loginUser');
    _userData = {};

    try {
      http.Response response = await http.post(uri, body: body);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({
          'token': jsonResponse['message']['token'],
          'code': response.statusCode
        });
      } else if (response.statusCode == 400) {
        String message = jsonResponse['message'] == 'Senha invalida'
            ? 'Dados inválidos'
            : jsonResponse['message'];

        _userData.addAll({'message': message, 'code': response.statusCode});
      }
    } on SocketException catch (error) {
      _userData.addAll({
        'socket_error': error.toString() == 'Connection failed'
            ? 'Verifique sua conexão com a internet.'
            : ''
      });
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<Map<String, dynamic>> balance(Map<String, String> headers) async {
    var uri = Uri.parse('$_address/getSimuCoin');
    _userData = {};

    try {
      http.Response response = await http.get(uri, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({
          'simu_coin': jsonResponse['message'],
          'code': response.statusCode
        });
      } else if (response.statusCode == 400) {
        _userData.addAll(
            {'message': jsonResponse['message'], 'code': response.statusCode});
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<List<Map<String, dynamic>>> devices(
      Map<String, String> headers) async {
    var uri = Uri.parse('$_address/listAllModels');
    _deviceData = [];

    try {
      http.Response response = await http.get(uri, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _deviceData.add({'code': response.statusCode});
        jsonResponse['message']?.forEach((element) {
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
        _deviceData.add({'code': response.statusCode});
        _deviceData.add({'message': jsonResponse['message']});
      }
    } catch (error) {
      _deviceData.add({'error': error});
    }

    return _deviceData;
  }
}

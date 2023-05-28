import 'dart:convert';

import 'package:http/http.dart' as http;

class Services {
  final String _address = 'http://10.0.2.2:300/api';
  late Map<String, dynamic> _data;

  Future<Map<String, dynamic>> register(Map<String, dynamic> body) async {
    var uri = Uri.parse('$_address/createUser');
    _data = {};

    try {
      http.Response response = await http.post(uri, body: body);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _data.addAll({
          'token': jsonResponse['message']['token'],
          'code': response.statusCode
        });
      } else if (response.statusCode == 400) {
        _data.addAll(
            {'message': jsonResponse['message'], 'code': response.statusCode});
      }
    } catch (error) {
      _data.addAll({'error': error});
    }

    return _data;
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    var uri = Uri.parse('$_address/loginUser');
    _data = {};

    try {
      http.Response response = await http.post(uri, body: body);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _data.addAll({
          'token': jsonResponse['message']['token'],
          'code': response.statusCode
        });
        print('201');
      } else if (response.statusCode == 400) {
        String message = jsonResponse['message'] == 'Senha invalida'
            ? 'Dados inválidos'
            : jsonResponse['message'];

        _data.addAll({'message': message, 'code': response.statusCode});
      }
      print('400');
    } catch (error) {
      _data.addAll({'error': error});
      print('$error');
    }

    print('aqui');
    return _data;
  }
}

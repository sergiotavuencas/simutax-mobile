import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UserServices {
  final String _address = 'http://164.152.62.200:3000/api';
  late Map<String, dynamic> _userData;

  Future<Map<String, dynamic>> register(Map<String, dynamic> body) async {
    var uri = Uri.parse('$_address/createUser');
    _userData = {};

    try {
      http.Response response = await http.post(uri, body: body);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({
          'token': jsonResponse['sucess']['token'],
        });
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
          'token': jsonResponse['sucess']['token'],
          'name': jsonResponse['sucess']['name'],
          'balance': jsonResponse['sucess']['balace'],
          'coin': jsonResponse['sucess']['coin'],
        });
      } else if (response.statusCode == 400) {
        String message = jsonResponse['sucess'] == 'Senha invalida'
            ? 'Dados inválidos'
            : jsonResponse['sucess'];

        _userData
            .addAll({'sucess': message, 'status_code': response.statusCode});
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
    var uri = Uri.parse('$_address/balance');
    _userData = {};

    try {
      http.Response response = await http.get(uri, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({
          'name': jsonResponse['sucess']['name'],
          'balance': jsonResponse['sucess']['balance'],
          'coin': jsonResponse['sucess']['coin'],
        });

        // print('Data: $_userData');
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<Map<String, dynamic>> forgot(Map<String, String> body) async {
    var uri = Uri.parse('$_address/forgotPassword');
    _userData = {};

    try {
      http.Response response = await http.post(uri, body: body);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({'code': jsonResponse['sucess']['code']});
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<Map<String, dynamic>> validate(Map<String, String> body) async {
    var uri = Uri.parse('$_address/validateToken');
    _userData = {};

    try {
      http.Response response = await http.post(uri, body: body);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({'code': jsonResponse['sucess']['token']});
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<Map<String, dynamic>> reset(Map<String, String> body) async {
    var uri = Uri.parse('$_address/resetPassword');
    _userData = {};

    try {
      http.Response response = await http.post(uri, body: body);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({'code': jsonResponse['sucess']['code']});
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<Map<String, dynamic>> edit(
      Map<String, String> body, Map<String, String> headers) async {
    var uri = Uri.parse('$_address/changeEmail');
    _userData = {};

    try {
      http.Response response =
          await http.put(uri, body: body, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({'code': jsonResponse['sucess']['code']});
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<Map<String, dynamic>> delete(
      Map<String, String> body, Map<String, String> headers) async {
    var uri = Uri.parse('$_address/disableUser');
    _userData = {};

    try {
      http.Response response =
          await http.put(uri, body: body, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({'code': jsonResponse['code']});
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<Map<String, dynamic>> updateBalance(
      Map<String, String> headers) async {
    var uri = Uri.parse('$_address/getBalance');
    _userData = {};

    try {
      http.Response response = await http.get(uri, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({'success': jsonResponse['sucess']['result']});
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }

  Future<Map<String, dynamic>> updateCoin(Map<String, String> headers) async {
    var uri = Uri.parse('$_address/getCoin');
    _userData = {};

    try {
      http.Response response = await http.get(uri, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _userData.addAll({'success': jsonResponse['sucess']['result']});
      }
    } catch (error) {
      _userData.addAll({'error': error});
    }

    return _userData;
  }
}

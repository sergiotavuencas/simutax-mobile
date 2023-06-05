import 'dart:convert';
// import 'dart:io';

import 'package:http/http.dart' as http;

class PaymentServices {
  final String _address = 'http://10.0.2.2:300/api';
  late Map<String, dynamic> _data;

  Future<Map<String, dynamic>> pix(
      Map<String, dynamic> body, Map<String, String> headers) async {
    var uri = Uri.parse('$_address/updateBalance');
    _data = {};

    try {
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _data.addAll({
          'code': jsonResponse['code'],
          'qr_code': jsonResponse['code']['qr_code'],
          'qr_code_base64': jsonResponse['code']['qr_code_base64']
        });
      }
    } catch (error) {
      _data.addAll({'error': error});
    }

    return _data;
  }
}

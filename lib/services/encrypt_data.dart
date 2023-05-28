import 'package:encrypt/encrypt.dart';

class EncryptData {
  static Encrypted? _encrypted;
  static var _decrypted;

  static String encryptAES(plainText) {
    final key = Key.fromUtf8('DrKcCK1pH35buLyNay/NwSo43tDcRjY=');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    _encrypted = encrypter.encrypt(plainText, iv: iv);

    return _encrypted!.base64;
  }

  static decryptAES(plainText) {
    final key = Key.fromUtf8('DrKcCK1pH35buLyNay/NwSo43tDcRjY=');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    _decrypted = encrypter.decrypt(_encrypted!, iv: iv);
  }

  static get aesEncrypted {
    return _encrypted;
  }

  static get aesDecrypted {
    return _decrypted;
  }
}

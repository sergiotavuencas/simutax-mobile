extension StringExtension on String {
  bool isValidEmail() => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  bool isValidPhone() => RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(this);

  bool isValidCpf() =>
      RegExp(r'([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})')
          .hasMatch(this);

  bool isWhitespace() => trim().isEmpty;

  bool hasNumber() {
    for (var i = 0; i < length; i++) {
      for (var j = 0; j < 10; j++) {
        if (this[i].contains(j.toString())) {
          return true;
        }
      }
    }

    return false;
  }

  bool hasSpace() {
    for (var i = 0; i < length; i++) {
      if (this[i].contains(" ")) {
        return true;
      }
    }

    return false;
  }

  bool hasLength(int min, int max) {
    if (length > (min - 1) && length < (max + 1)) {
      return true;
    }

    return false;
  }
}

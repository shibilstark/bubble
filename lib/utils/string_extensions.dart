extension Validators on String {
  bool isPasswordValid() => length >= 8;

  bool isEmailValid() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(this);
  }

  bool isPhoneNumber() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this)
        //  && length > 8
        ;
  }
}

extension CustomMethodes on String? {
  bool isNull() => this == null || this!.trim().isEmpty;
}

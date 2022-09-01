import 'package:flutter/material.dart';

class Validators {
  static final Validators _validators = Validators._internal();

  factory Validators() {
    return _validators;
  }

  Validators._internal();

  FormFieldValidator<String>? emailValidator = (String? value) {
    const String emailRegex =
        r'''[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?''';
    if (value == null) {
      return 'Enter Email';
    } else if (value.isEmpty) {
      return 'Enter Email';
    } else if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Email not valid';
    }
    return null;
  };

  FormFieldValidator<String>? passwordValidator = (String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Enter password';
    }
    return null;
  };

  FormFieldValidator<String>? emptyTextValidator(String errorText) {
    return (String? value) {
      if (value == null) {
        return null;
      }
      if (value.isEmpty) {
        return errorText;
      }
      return null;
    };
  }
}

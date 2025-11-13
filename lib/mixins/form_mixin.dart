import 'package:flutter/material.dart';

mixin FormMixin {
  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }
}
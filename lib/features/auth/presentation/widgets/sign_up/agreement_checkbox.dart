import 'package:flutter/material.dart';

class AgreementCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AgreementCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        const Expanded(
          child: Text(
            "By creating an account, you agree to our Terms and Conditions and Privacy Notice.",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}